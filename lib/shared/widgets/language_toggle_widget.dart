import 'package:flutter/material.dart';

import '../../core/di/injection_container.dart';
import '../../core/localization/localization_service.dart';

class LanguageToggleWidget extends StatelessWidget {
  const LanguageToggleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        sl<LocalizationService>().changeLanguage(context);
      },
      icon: const Icon(Icons.language),
    );
  }
}