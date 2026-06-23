import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppDesignSpacing {
  const AppDesignSpacing({
    required this.xs,
    required this.sm,
    required this.md,
    required this.lg,
    required this.xl,
    required this.xxl,
    required this.page,
    required this.bottomSafeArea,
  });

  final double xs;
  final double sm;
  final double md;
  final double lg;
  final double xl;
  final double xxl;
  final double page;
  final double bottomSafeArea;

  factory AppDesignSpacing.mobile() {
    return AppDesignSpacing(
      xs: 4.w,
      sm: 8.w,
      md: 12.w,
      lg: 16.w,
      xl: 24.w,
      xxl: 32.w,
      page: 16.w,
      bottomSafeArea: 20.h,
    );
  }

  factory AppDesignSpacing.tablet() {
    return AppDesignSpacing(
      xs: 6.w,
      sm: 10.w,
      md: 14.w,
      lg: 20.w,
      xl: 28.w,
      xxl: 40.w,
      page: 24.w,
      bottomSafeArea: 24.h,
    );
  }
}
