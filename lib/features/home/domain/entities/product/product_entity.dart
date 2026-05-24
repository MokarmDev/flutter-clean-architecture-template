import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
part 'product_entity.g.dart';

@HiveType(typeId: 0)
class ProductEntity extends Equatable {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final String category;
  @HiveField(4)
  final double price;
  @HiveField(5)
  final double discountPercentage;
  @HiveField(6)
  final double rating;
  @HiveField(7)
  final int stock;
  @HiveField(8)
  final List<String> tags;
  @HiveField(9)
  final String? brand;
  @HiveField(10)
  final String sku;
  @HiveField(11)
  final int weight;
  @HiveField(12)
  final DimensionsEntity dimensions;
  @HiveField(13)
  final String warrantyInformation;
  @HiveField(14)
  final String shippingInformation;
  @HiveField(15)
  final String availabilityStatus;
  @HiveField(16)
  final List<ReviewEntity> reviews;
  @HiveField(17)
  final String returnPolicy;
  @HiveField(18)
  final int minimumOrderQuantity;
  @HiveField(19)
  final MetaEntity meta;
  @HiveField(20)
  final List<String> images;
  @HiveField(21)
  final String thumbnail;

  const ProductEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.tags,
    this.brand,
    required this.sku,
    required this.weight,
    required this.dimensions,
    required this.warrantyInformation,
    required this.shippingInformation,
    required this.availabilityStatus,
    required this.reviews,
    required this.returnPolicy,
    required this.minimumOrderQuantity,
    required this.meta,
    required this.images,
    required this.thumbnail,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    category,
    price,
    discountPercentage,
    rating,
    stock,
    tags,
    brand,
    sku,
    weight,
    dimensions,
    warrantyInformation,
    shippingInformation,
    availabilityStatus,
    reviews,
    returnPolicy,
    minimumOrderQuantity,
    meta,
    images,
    thumbnail,
  ];
}

@HiveType(typeId: 1)
class DimensionsEntity extends Equatable {
  @HiveField(0)
  final double width;
  @HiveField(1)
  final double height;
  @HiveField(2)
  final double depth;

  const DimensionsEntity({
    required this.width,
    required this.height,
    required this.depth,
  });

  @override
  List<Object?> get props => [width, height, depth];
}

@HiveType(typeId: 2)
class ReviewEntity extends Equatable {
  @HiveField(0)
  final int rating;
  @HiveField(1)
  final String comment;
  @HiveField(2)
  final DateTime date;
  @HiveField(3)
  final String reviewerName;
  @HiveField(4)
  final String reviewerEmail;

  const ReviewEntity({
    required this.rating,
    required this.comment,
    required this.date,
    required this.reviewerName,
    required this.reviewerEmail,
  });

  @override
  List<Object?> get props => [
    rating,
    comment,
    date,
    reviewerName,
    reviewerEmail,
  ];
}

@HiveType(typeId: 3)
class MetaEntity extends Equatable {
  @HiveField(0)
  final DateTime createdAt;
  @HiveField(1)
  final DateTime updatedAt;
  @HiveField(2)
  final String barcode;
  @HiveField(3)
  final String qrCode;

  const MetaEntity({
    required this.createdAt,
    required this.updatedAt,
    required this.barcode,
    required this.qrCode,
  });

  @override
  List<Object?> get props => [createdAt, updatedAt, barcode, qrCode];
}

