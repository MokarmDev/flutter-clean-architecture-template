import '../../core/di/injection_container.dart';
import '../../core/network/api_consumer.dart';
import 'data/datasources/{{feature_name.snakeCase()}}_remote_data_source.dart';
import 'data/repositories/{{feature_name.snakeCase()}}_repository_impl.dart';
import 'domain/repositories/{{feature_name.snakeCase()}}_repository.dart';
import 'domain/usecases/get_{{entity_name.snakeCase()}}s_usecase.dart';
import 'presentation/manager/{{entity_name.snakeCase()}}/{{entity_name.snakeCase()}}_cubit.dart';

void init{{feature_name.pascalCase()}}() {
  // ── State Management ────────────────────────────────────────────────────────
  sl.registerFactory(
    () => {{entity_name.pascalCase()}}Cubit(sl<Get{{entity_name.pascalCase()}}sUseCase>()),
  );

  // ── Use Cases ────────────────────────────────────────────────────────────────
  sl.registerLazySingleton(
    () => Get{{entity_name.pascalCase()}}sUseCase(sl<{{feature_name.pascalCase()}}Repository>()),
  );

  // ── Repository ───────────────────────────────────────────────────────────────
  sl.registerLazySingleton<{{feature_name.pascalCase()}}Repository>(
    () => {{feature_name.pascalCase()}}RepositoryImpl(
      sl<{{feature_name.pascalCase()}}RemoteDataSource>(),
    ),
  );

  // ── Data Sources ─────────────────────────────────────────────────────────────
  sl.registerLazySingleton<{{feature_name.pascalCase()}}RemoteDataSource>(
    () => {{feature_name.pascalCase()}}RemoteDataSourceImpl(sl<ApiConsumer>()),
  );
}
