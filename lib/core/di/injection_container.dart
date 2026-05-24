import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import '../../features/cart/cart_injection.dart';
import '../../features/home/domain/entities/product/product_entity.dart';
import '../../features/home/home_injection.dart';
import '../../features/profile/profile_injection.dart';
import '../../features/theme/theme_injection.dart';
import '../localization/localization_service.dart';
import '../network/api_consumer.dart';
import '../network/dio_consumer.dart';
import '../network/network_info.dart';
import '../storage/secure_storage_service.dart';
import '../storage/shared_prefs_service.dart';
import '../storage/storage_keys.dart';

final sl = GetIt.instance; // sl = Service Locator

Future<void> initCore() async {
  // Storage
  await Hive.initFlutter();
  Hive.registerAdapter(ProductEntityAdapter());
  Hive.registerAdapter(DimensionsEntityAdapter());
  Hive.registerAdapter(ReviewEntityAdapter());
  Hive.registerAdapter(MetaEntityAdapter());
  await Hive.openBox<ProductEntity>(StorageKeys.product_box);

  await SharedPreferencesService.init();
  await LocalizationService.initialize();
  sl.registerLazySingleton(() => SharedPreferencesService());
  sl.registerLazySingleton(() => LocalizationService());
  sl.registerLazySingleton(
    () => SecureStorageService(const FlutterSecureStorage()),
  );

  initTheme();
  // External
  sl.registerLazySingleton(() => InternetConnection());
  sl.registerLazySingleton(() => Dio());

  // Core
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(sl<InternetConnection>()),
  );

  sl.registerLazySingleton<ApiConsumer>(() => DioConsumer(dio: sl<Dio>()));

  // Features
  initHome();
  initCart();
  initProfile();
}
