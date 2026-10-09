import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_template/core/errors/failures.dart';
import 'package:flutter_clean_architecture_template/features/home/domain/entities/product/product_entity.dart';
import 'package:flutter_clean_architecture_template/features/home/domain/repositories/home_repository.dart';
import 'package:flutter_clean_architecture_template/features/home/domain/usecases/get_product_usecase.dart';
import 'package:flutter_clean_architecture_template/shared/models/pagination/pagination_params.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/product_test_fixtures.dart';

class _FakeHomeRepository implements HomeRepository {
  Either<Failure, List<ProductEntity>>? nextResult;
  PaginationParams? lastParams;

  @override
  Future<Either<Failure, List<ProductEntity>>> getProduct(
    PaginationParams params,
  ) async {
    lastParams = params;
    return nextResult ?? Right([createProductEntity()]);
  }
}

void main() {
  late _FakeHomeRepository repository;
  late GetProductUseCase useCase;

  setUp(() {
    repository = _FakeHomeRepository();
    useCase = GetProductUseCase(repository);
  });

  test('forwards params and returns repository success', () async {
    final products = [createProductEntity(id: 7)];
    repository.nextResult = Right(products);

    final result = await useCase.call(
      const PaginationParams(skip: 10, limit: 5),
    );

    expect(repository.lastParams?.skip, 10);
    expect(repository.lastParams?.limit, 5);
    expect(result, Right(products));
  });

  test('returns repository failure', () async {
    const failure = ServerFailure('boom');
    repository.nextResult = const Left(failure);

    final result = await useCase.call();

    expect(result, const Left(failure));
  });
}
