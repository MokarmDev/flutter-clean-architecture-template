import 'package:hive/hive.dart';

import '../../../../core/storage/storage_keys.dart';
import '../../../../shared/models/pagination/paginated_response.dart';
import '../../../../shared/models/pagination/pagination_params.dart';
import '../../domain/entities/product/product_entity.dart';

abstract class HomeLocalDataSource {
  // You can keep your old methods if they serve other purposes
  List<ProductEntity> fetchProducts();
  Future<void> saveProducts(List<ProductEntity> products);

  // New batch methods
  Future<void> saveProductsBatch(
    PaginationParams batchParams,
    PaginatedResponse<ProductEntity> batch,
  );
  Future<PaginatedResponse<ProductEntity>?> fetchProductsBatch(
    PaginationParams batchParams,
  );
}

class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  HomeLocalDataSourceImpl();

  // ---- old methods (unchanged) ----
  @override
  List<ProductEntity> fetchProducts() {
    final products = Hive.box<ProductEntity>(StorageKeys.product_box);
    return products.values.toList();
  }

  @override
  Future<void> saveProducts(List<ProductEntity> products) async {
    final productBox = Hive.box<ProductEntity>(StorageKeys.product_box);
    productBox.addAll(products);
  }

  // ---- new batch methods ----
  @override
  Future<void> saveProductsBatch(
    PaginationParams batchParams,
    PaginatedResponse<ProductEntity> batch,
  ) async {
    final batchBox = Hive.box<CachedProductBatch>(StorageKeys.batch_box);

    final cacheEntry = CachedProductBatch(
      total: batch.total,
      skip: batch.skip,
      limit: batch.limit,
      products: batch.data,
    );

    // Key by skip_limit so we can find it later
    await batchBox.put('${batchParams.skip}_${batchParams.limit}', cacheEntry);
  }

  @override
  Future<PaginatedResponse<ProductEntity>?> fetchProductsBatch(
    PaginationParams batchParams,
  ) async {
    final batchBox = Hive.box<CachedProductBatch>(StorageKeys.batch_box);
    final cached = batchBox.get('${batchParams.skip}_${batchParams.limit}');

    if (cached == null) return null;

    return PaginatedResponse<ProductEntity>(
      data: cached.products,
      total: cached.total,
      limit: cached.limit,
      skip: cached.skip,
    );
  }
}
