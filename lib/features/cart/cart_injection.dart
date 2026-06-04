import '../../core/di/injection_container.dart';
import 'data/datasources/cart_remote_data_source.dart';
import 'data/repositories/cart_repository_impl.dart';
import 'domain/repositories/cart_repository.dart';
import 'domain/usecases/get_cart_usecase.dart';
import 'presentation/manager/cart_cubit.dart';

void initCart() {
  // State Management
  sl.registerFactory(() => CartCubit());

  // Use Cases
  sl.registerLazySingleton(() => GetCartUseCase(sl()));

  // Repository
  sl.registerLazySingleton<CartRepository>(() => CartRepositoryImpl(sl()));

  // Data Sources
  sl.registerLazySingleton<CartRemoteDataSource>(
    () => CartRemoteDataSourceImpl(),
  );
}
