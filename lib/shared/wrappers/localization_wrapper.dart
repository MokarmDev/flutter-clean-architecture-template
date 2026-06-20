import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../core/di/injection_container.dart';
import '../../core/localization/localization_service.dart';

/// A wrapper to initialize [EasyLocalization] with supported locales.
class LocalizationWrapper extends StatelessWidget {
  final Widget child;

  const LocalizationWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final localizationService = sl<LocalizationService>();

    return EasyLocalization(
      path: localizationService.translationPath,
      supportedLocales: localizationService.supportedLocales,
      fallbackLocale: localizationService.fallbackLocale,
      startLocale: localizationService.currentLocale,
      saveLocale: true,
      useOnlyLangCode: true,
      child: child,
    );
  }
}
