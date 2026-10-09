import 'package:flutter_clean_architecture_template/features/home/data/models/product/dimensions_model.dart';
import 'package:flutter_clean_architecture_template/features/home/data/models/product/meta_model.dart';
import 'package:flutter_clean_architecture_template/features/home/data/models/product/product_model.dart';
import 'package:flutter_clean_architecture_template/features/home/domain/entities/product/product_entity.dart';

ProductModel createProductModel({
  int id = 1,
  String title = 'Test product',
}) {
  final now = DateTime(2024, 1, 1);
  return ProductModel(
    id: id,
    title: title,
    description: 'desc',
    category: 'cat',
    price: 10,
    discountPercentage: 0,
    rating: 4,
    stock: 1,
    tags: const [],
    sku: 'sku-$id',
    weight: 1,
    dimensions: const DimensionsModel(width: 1, height: 1, depth: 1),
    warrantyInformation: '',
    shippingInformation: '',
    availabilityStatus: 'In Stock',
    reviews: const [],
    returnPolicy: '',
    minimumOrderQuantity: 1,
    meta: MetaModel(
      createdAt: now,
      updatedAt: now,
      barcode: '',
      qrCode: '',
    ),
    images: const [],
    thumbnail: '',
  );
}

ProductEntity createProductEntity({
  int id = 1,
  String title = 'Test product',
}) =>
    createProductModel(id: id, title: title);
