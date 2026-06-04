import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/network/api_consumer.dart';
import '../../../../shared/models/pagination/pagination_params.dart';
import '../../domain/entities/product/product_entity.dart';
import '../models/product/product_model.dart';

abstract class HomeRemoteDataSource {
  Future<List<ProductEntity>> fetchProduct(PaginationParams params);
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final ApiConsumer _dio;

  HomeRemoteDataSourceImpl(this._dio);

  @override
  Future<List<ProductEntity>> fetchProduct(PaginationParams params) async {
    final response = await _dio.get(
      ApiEndpoints.products,
      queryParameters: params.toJson(),
    );

    final List<ProductEntity> products = (response['products'] as List)
        .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
        .toList();

    return products;
  }
}
