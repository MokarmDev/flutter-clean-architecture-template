import 'package:flutter/material.dart';

class AppWrapper extends StatelessWidget {
  final Widget child;
  static const double minScale = 1.0;
  static const double maxScale = 1.0;

  const AppWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final scale = mediaQuery.textScaler.scale(1).clamp(minScale, maxScale);

    return MediaQuery(
      data: mediaQuery.copyWith(textScaler: TextScaler.linear(scale)),
      child: Padding(
        padding: EdgeInsets.only(bottom: mediaQuery.padding.bottom),
        child: child,
      ),
    );
  }
}