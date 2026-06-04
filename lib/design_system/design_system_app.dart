import 'package:flutter/material.dart';

import 'src/theme/app_design_theme.dart';

class DesignSystemApp extends StatelessWidget {
  const DesignSystemApp({
    super.key,
    required this.designTheme,
    required this.child,
    this.lockTextScale = true,
  });

  final AppDesignTheme designTheme;
  final Widget child;
  final bool lockTextScale;

  static AppDesignTheme of(BuildContext context) {
    final inherited = context
        .dependOnInheritedWidgetOfExactType<_InheritedDesignSystemApp>();
    assert(inherited != null, 'No DesignSystemApp found in context.');
    return inherited!.designTheme;
  }

  @override
  Widget build(BuildContext context) {
    final content = _InheritedDesignSystemApp(
      designTheme: designTheme,
      child: child,
    );

    if (!lockTextScale) {
      return content;
    }

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: TextScaler.noScaling),
      child: content,
    );
  }
}

class _InheritedDesignSystemApp extends InheritedWidget {
  const _InheritedDesignSystemApp({
    required this.designTheme,
    required super.child,
  });

  final AppDesignTheme designTheme;

  @override
  bool updateShouldNotify(_InheritedDesignSystemApp oldWidget) {
    return designTheme != oldWidget.designTheme;
  }
}
