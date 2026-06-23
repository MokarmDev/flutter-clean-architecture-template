import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppDesignRadius {
  AppDesignRadius({
    required this.xs,
    required this.sm,
    required this.md,
    required this.lg,
    required this.xl,
    required this.pill,
  });

  final Radius xs;
  final Radius sm;
  final Radius md;
  final Radius lg;
  final Radius xl;
  final Radius pill;

  BorderRadius get xsBorder => BorderRadius.all(xs);
  BorderRadius get smBorder => BorderRadius.all(sm);
  BorderRadius get mdBorder => BorderRadius.all(md);
  BorderRadius get lgBorder => BorderRadius.all(lg);
  BorderRadius get xlBorder => BorderRadius.all(xl);
  BorderRadius get pillBorder => BorderRadius.all(pill);

  factory AppDesignRadius.regular() {
    return AppDesignRadius(
      xs: Radius.circular(4.r),
      sm: Radius.circular(8.r),
      md: Radius.circular(12.r),
      lg: Radius.circular(16.r),
      xl: Radius.circular(24.r),
      pill: Radius.circular(360.r),
    );
  }
}
