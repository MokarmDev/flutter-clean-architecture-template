import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../shared/models/pagination/paginated_response.dart';
import '../entities/product/product_entity.dart';

abstract class HomeRepository {
  Future<Either<Failure, PaginatedResponse<ProductEntity>>> getProductPage({
    required int page,
    int pageSize = 10,
  });
}
