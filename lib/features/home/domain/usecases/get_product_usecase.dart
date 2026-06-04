import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../shared/models/pagination/pagination_params.dart';
import '../../../../shared/use_cases/use_case.dart';
import '../entities/product/product_entity.dart';
import '../repositories/home_repository.dart';

class GetProductUseCase
    implements UseCase<List<ProductEntity>, PaginationParams> {
  final HomeRepository repository;

  GetProductUseCase(this.repository);

  @override
  Future<Either<Failure, List<ProductEntity>>> call([
    PaginationParams? param,
  ]) async {
    return await repository.getProduct(param ?? const PaginationParams());
  }
}
