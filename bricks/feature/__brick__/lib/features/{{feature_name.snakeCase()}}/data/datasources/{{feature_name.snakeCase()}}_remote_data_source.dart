import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/network/api_consumer.dart';
import '../models/{{entity_name.snakeCase()}}_model.dart';

abstract class {{feature_name.pascalCase()}}RemoteDataSource {
  Future<List<{{entity_name.pascalCase()}}Model>> fetch{{entity_name.pascalCase()}}s();
}

class {{feature_name.pascalCase()}}RemoteDataSourceImpl
    implements {{feature_name.pascalCase()}}RemoteDataSource {
  final ApiConsumer _dio;

  {{feature_name.pascalCase()}}RemoteDataSourceImpl(this._dio);

  @override
  Future<List<{{entity_name.pascalCase()}}Model>> fetch{{entity_name.pascalCase()}}s() async {
    // TODO: replace ApiEndpoints.products with the correct endpoint
    final response = await _dio.get(ApiEndpoints.products);
    return (response as List)
        .map((e) => {{entity_name.pascalCase()}}Model.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
