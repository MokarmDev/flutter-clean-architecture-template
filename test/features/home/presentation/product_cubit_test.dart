import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_template/core/errors/failures.dart';
import 'package:flutter_clean_architecture_template/features/home/domain/entities/product/product_entity.dart';
import 'package:flutter_clean_architecture_template/features/home/domain/repositories/home_repository.dart';
import 'package:flutter_clean_architecture_template/features/home/domain/usecases/get_product_usecase.dart';
import 'package:flutter_clean_architecture_template/features/home/presentation/manager/product/product_cubit.dart';
import 'package:flutter_clean_architecture_template/features/home/presentation/manager/product/product_state.dart';
import 'package:flutter_clean_architecture_template/shared/models/pagination/pagination_params.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/product_test_fixtures.dart';

class _FakeHomeRepository implements HomeRepository {
  Either<Failure, List<ProductEntity>> nextResult = const Right([]);

  @override
  Future<Either<Failure, List<ProductEntity>>> getProduct(
    PaginationParams params,
  ) async {
    return nextResult;
  }
}

void main() {
  late _FakeHomeRepository repository;
  late ProductCubit cubit;

  setUp(() {
    repository = _FakeHomeRepository();
    cubit = ProductCubit(GetProductUseCase(repository));
  });

  tearDown(() async {
    await cubit.close();
  });

  test('emits loading then loaded on success', () async {
    final products = [createProductEntity(id: 1)];
    repository.nextResult = Right(products);

    expectLater(
      cubit.stream,
      emitsInOrder([
        isA<ProductLoading>(),
        isA<ProductLoaded>(),
      ]),
    );

    await cubit.loadProducts(limit: 10);

    expect(cubit.state, isA<ProductLoaded>());
    expect(cubit.products, products);
    expect(cubit.hasReachedMax, isTrue);
  });

  test('emits error when use case fails', () async {
    repository.nextResult = const Left(ServerFailure('failed'));

    expectLater(
      cubit.stream,
      emitsInOrder([
        isA<ProductLoading>(),
        isA<ProductError>(),
      ]),
    );

    await cubit.loadProducts(limit: 10);

    final state = cubit.state as ProductError;
    expect(state.message, 'failed');
  });

  test('refresh clears products before reload', () async {
    repository.nextResult = Right([createProductEntity(id: 1)]);
    await cubit.loadProducts(limit: 10);

    repository.nextResult = Right([createProductEntity(id: 2)]);
    await cubit.loadProducts(limit: 10, isRefresh: true);

    expect(cubit.products.single.id, 2);
  });
}
