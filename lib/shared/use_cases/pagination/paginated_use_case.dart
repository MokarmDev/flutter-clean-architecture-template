import 'package:dartz/dartz.dart';

import '../../../core/errors/failures.dart';
import 'pagination_params.dart';

/// A specialized UseCase signature for paginated requests.
abstract class PaginatedUseCase<T> {
  Future<Either<Failure, T>> call({required PaginationParams params});
}
