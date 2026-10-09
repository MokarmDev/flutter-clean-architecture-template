import 'package:dio/dio.dart';
import 'package:flutter_clean_architecture_template/core/errors/failures.dart';
import 'package:flutter_clean_architecture_template/features/home/data/datasources/home_local_data_source.dart';
import 'package:flutter_clean_architecture_template/features/home/data/datasources/home_remote_data_source.dart';
import 'package:flutter_clean_architecture_template/features/home/data/repositories/home_repository_impl.dart';
import 'package:flutter_clean_architecture_template/features/home/domain/entities/product/product_entity.dart';
import 'package:flutter_clean_architecture_template/shared/models/pagination/pagination_params.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/product_test_fixtures.dart';

class _FakeRemote implements HomeRemoteDataSource {
  Object? throwError;
  List<ProductEntity> products = [];

  @override
  Future<List<ProductEntity>> fetchProduct(PaginationParams params) async {
    if (throwError != null) {
      throw throwError!;
    }
    return products;
  }
}

class _FakeLocal implements HomeLocalDataSource {
  List<ProductEntity> cached = [];
  bool? lastReplace;
  List<ProductEntity>? lastSaved;

  @override
  List<ProductEntity> fetchProducts() => List.from(cached);

  @override
  Future<void> saveProducts(
    List<ProductEntity> products, {
    bool replace = false,
  }) async {
    lastReplace = replace;
    lastSaved = products;
    if (replace) {
      cached = List.from(products);
    } else {
      cached.addAll(products);
    }
  }
}

void main() {
  late _FakeRemote remote;
  late _FakeLocal local;
  late HomeRepositoryImpl repository;

  setUp(() {
    remote = _FakeRemote();
    local = _FakeLocal();
    repository = HomeRepositoryImpl(
      remoteDataSource: remote,
      localDataSource: local,
    );
  });

  test('returns remote products and replaces cache on first page', () async {
    final products = [createProductModel(id: 1)];
    remote.products = products;

    final result = await repository.getProduct(
      const PaginationParams(skip: 0, limit: 10),
    );

    expect(result.isRight(), isTrue);
    result.fold((_) => fail('expected success'), (value) {
      expect(value, products);
    });
    expect(local.lastReplace, isTrue);
    expect(local.lastSaved, products);
  });

  test('appends cache when skip is not zero', () async {
    remote.products = [createProductModel(id: 2)];

    await repository.getProduct(const PaginationParams(skip: 10, limit: 10));

    expect(local.lastReplace, isFalse);
  });

  test('returns cached products when remote fails and cache is not empty', () async {
    local.cached = [createProductEntity(id: 9, title: 'Cached')];
    remote.throwError = DioException(
      requestOptions: RequestOptions(path: '/products'),
      type: DioExceptionType.connectionError,
    );

    final result = await repository.getProduct(const PaginationParams());

    expect(result.isRight(), isTrue);
    result.fold((_) => fail('expected cache fallback'), (value) {
      expect(value.single.id, 9);
      expect(value.single.title, 'Cached');
    });
  });

  test('returns failure when remote fails and cache is empty', () async {
    remote.throwError = DioException(
      requestOptions: RequestOptions(path: '/products'),
      type: DioExceptionType.connectionError,
    );

    final result = await repository.getProduct(const PaginationParams());

    expect(result.isLeft(), isTrue);
    result.fold(
      (failure) => expect(failure, isA<Failure>()),
      (_) => fail('expected failure'),
    );
  });
}
