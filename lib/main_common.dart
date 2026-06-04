import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_flavor/flutter_flavor.dart';

import 'core/bloc/app_bloc_observer.dart';
import 'core/constants/app_strings.dart';
import 'core/di/injection_container.dart';
import 'my_app.dart';
import 'shared/wrappers/localization_wrapper.dart';

Future<void> mainCommon({required String name, required String baseUrl}) async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kDebugMode) {
    Bloc.observer = AppBlocObserver();
  }
  await initCore();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  FlavorConfig(
    name: name,
    color: name == AppStrings.dev ? Colors.green : Colors.red,
    variables: {AppStrings.baseUrl: baseUrl},
  );

  runApp(LocalizationWrapper(child: MyApp()));
}

// to run dev flavor
// flutter run --flavor dev -t lib/main_dev.dart
// to run prod flavor
// flutter run --flavor prod -t lib/main_prod.dart
// to generate translations with keys
// dart run easy_localization:generate --source-dir ./assets/translations -f keys -o locale_keys.g.dart
// to generate env
// dart run build_runner build
// to generate feature
// mason make feature --feature_name home --entity_name Home 
// to generate assets
// dart pub global run flutter_gen:flutter_gen_command
// or add Pub Cache\bin to PATH then: fluttergen
// to generate hive
// flutter packages pub run  build_runner build
