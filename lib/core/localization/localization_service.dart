import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../di/injection_container.dart';
import '../storage/shared_prefs_service.dart';
import '../storage/storage_keys.dart';

class LocalizationService {
  final String translationPath = 'assets/translations';

  final List<Locale> supportedLocales = const [Locale('ar'), Locale('en')];

  final Locale fallbackLocale = const Locale('en');

  static Future<void> initialize() async {
    await EasyLocalization.ensureInitialized();
  }

  Locale get currentLocale {
    final code = sl<SharedPreferencesService>().getString(StorageKeys.locale);

    if (code == null) return fallbackLocale;

    return supportedLocales.any((l) => l.languageCode == code)
        ? Locale(code)
        : fallbackLocale;
  }

  void setLocale(BuildContext context, Locale locale) {
    if (currentLocale != locale) {
      context.setLocale(locale);
      sl<SharedPreferencesService>().saveString(
        StorageKeys.locale,
        locale.languageCode,
      );
    }
  }

  void changeLanguage(BuildContext context) {
    final newLocale = currentLocale.languageCode == 'ar'
        ? const Locale('en')
        : const Locale('ar');

    setLocale(context, newLocale);
  }

  bool get isRTL => ['ar'].contains(currentLocale.languageCode);
}
