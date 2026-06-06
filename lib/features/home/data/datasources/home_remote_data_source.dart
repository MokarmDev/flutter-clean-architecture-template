import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/network/api_consumer.dart';
import '../../../../shared/models/pagination/paginated_response.dart';
import '../../../../shared/models/pagination/pagination_params.dart';
import '../models/product/product_model.dart';

abstract class HomeRemoteDataSource {
  Future<PaginatedResponse<ProductModel>> fetchProduct(PaginationParams params);
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final ApiConsumer _dio;

  HomeRemoteDataSourceImpl(this._dio);

  @override
  Future<PaginatedResponse<ProductModel>> fetchProduct(
    PaginationParams params,
  ) async {
    final response = await _dio.get(
      ApiEndpoints.products,
      queryParameters: params.toJson(),
    );

    final List<ProductModel> products = (response['products'] as List)
        .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
        .toList();

    return PaginatedResponse<ProductModel>(
      data: products,
      total: response['total'] as int,
      limit: response['limit'] as int,
      skip: response['skip'] as int,
    );
  }
}
