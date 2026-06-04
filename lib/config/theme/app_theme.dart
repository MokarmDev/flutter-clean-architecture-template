import 'package:flutter/material.dart';

import '../../design_system/design_system.dart';

class AppTheme {
  AppTheme._();

  static AppDesignTheme get lightDesign => AppDesignTheme.light();
  static AppDesignTheme get darkDesign => AppDesignTheme.dark();

  static ThemeData get lightTheme => lightDesign.toThemeData();
  static ThemeData get darkTheme => darkDesign.toThemeData();
}
