import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../shared/models/pagination/paginated_response.dart';
import '../entities/product/product_entity.dart';
import '../repositories/home_repository.dart';

class GetProductUseCase {
  final HomeRepository repository;

  GetProductUseCase(this.repository);

  Future<Either<Failure, PaginatedResponse<ProductEntity>>> call({
    required int page,
    int pageSize = 10,
  }) async {
    return await repository.getProductPage(page: page, pageSize: pageSize);
  }
}
