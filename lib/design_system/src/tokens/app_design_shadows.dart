import 'package:flutter/material.dart';

import 'app_design_colors.dart';

class AppDesignShadows {
  const AppDesignShadows({required this.card, required this.overlay});

  final List<BoxShadow> card;
  final List<BoxShadow> overlay;

  factory AppDesignShadows.fromColors(AppDesignColors colors) {
    return AppDesignShadows(
      card: [
        BoxShadow(
          color: colors.shadow,
          blurRadius: 18,
          offset: const Offset(0, 8),
        ),
      ],
      overlay: [
        BoxShadow(
          color: colors.shadow.withValues(alpha: 0.18),
          blurRadius: 28,
          offset: const Offset(0, 16),
        ),
      ],
    );
  }
}
