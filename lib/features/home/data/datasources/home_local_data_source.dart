import 'package:hive/hive.dart';

import '../../../../core/storage/storage_keys.dart';
import '../../domain/entities/product/product_entity.dart';
import '../models/product/product_model.dart';

abstract class HomeLocalDataSource {
  List<ProductEntity> fetchProducts();

  /// Persists [products]. When [replace] is true (first page / refresh),
  /// clears the box first so pagination does not accumulate duplicates.
  Future<void> saveProducts(
    List<ProductEntity> products, {
    bool replace = false,
  });
}

class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  HomeLocalDataSourceImpl();

  @override
  List<ProductEntity> fetchProducts() {
    final products = Hive.box<ProductEntity>(StorageKeys.product_box);

    return products.values.toList();
  }

  @override
  Future<void> saveProducts(
    List<ProductEntity> products, {
    bool replace = false,
  }) async {
    final productBox = Hive.box<ProductEntity>(StorageKeys.product_box);
    if (replace) {
      await productBox.clear();
    }
    await productBox.addAll(
      products.map((e) => (e as ProductModel).toEntity()).toList(),
    );
  }
}
