import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/utils/safe_call.dart';
import '../../../../shared/models/pagination/paginated_response.dart';
import '../../../../shared/models/pagination/pagination_params.dart';
import '../../domain/entities/product/product_entity.dart';
import '../../domain/repositories/home_repository.dart';
import '../datasources/home_local_data_source.dart';
import '../datasources/home_remote_data_source.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;
  final HomeLocalDataSource localDataSource;

  static const int _pagesPerBatch = 5; // configurable

  HomeRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, PaginatedResponse<ProductEntity>>> getProductPage({
    required int page,
    int pageSize = 10,
  }) async {
    final batchIndex = page ~/ _pagesPerBatch;

    // 1. Batch params
    final batchParams = PaginationParams.forBatch(
      batchIndex: batchIndex,
      pageSize: pageSize,
      pagesPerBatch: _pagesPerBatch,
    );

    // 2. Try local cache
    final cachedBatch = await localDataSource.fetchProductsBatch(batchParams);
    if (cachedBatch != null) {
      return Right(cachedBatch.pageAt(page, pageSize));
    }

    // 3. Fetch from remote (safeCall wraps the network call)
    final result = await safeCall(
      () => remoteDataSource.fetchProduct(batchParams),
    );

    return result.fold((failure) => Left(failure), (remoteBatch) async {
      // 4. Map to entity
      final entityBatch = remoteBatch.map((model) => model.toEntity());

      // 5. Cache the whole batch locally
      await localDataSource.saveProductsBatch(batchParams, entityBatch);

      // 6. Return the exact page
      return Right(entityBatch.pageAt(page, pageSize));
    });
  }
}
