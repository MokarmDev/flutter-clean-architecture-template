import 'package:flutter/material.dart';

extension ContextExtensions on BuildContext {

  // theme
  ThemeData get theme => Theme.of(this);
  ColorScheme get colors => theme.colorScheme;
  TextTheme get text => theme.textTheme;

  // screen size
  Size get screenSize => MediaQuery.of(this).size;
  double get width => screenSize.width;
  double get height => screenSize.height;

  // text theme
  TextStyle get title => text.titleLarge!;
  TextStyle get subtitle => text.titleMedium!;
  TextStyle get body => text.bodyMedium!;
  TextStyle get caption => text.bodySmall!;

  // navigation
  void pop<T>([T? result]) => Navigator.pop(this, result);

  Future<T?> push<T>(Widget page) {
    return Navigator.push(
      this,
      MaterialPageRoute(builder: (_) => page),
    );
  }
}