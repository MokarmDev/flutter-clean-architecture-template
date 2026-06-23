import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../tokens/app_design_colors.dart';
import '../tokens/app_design_radius.dart';
import '../tokens/app_design_shadows.dart';
import '../tokens/app_design_spacing.dart';
import '../tokens/app_design_typography.dart';

@immutable
class AppDesignTheme {
  const AppDesignTheme({
    required this.brightness,
    required this.colors,
    required this.spacing,
    required this.radius,
    required this.shadows,
    required this.typography,
  });

  final Brightness brightness;
  final AppDesignColors colors;
  final AppDesignSpacing spacing;
  final AppDesignRadius radius;
  final AppDesignShadows shadows;
  final AppDesignTypography typography;

  bool get isDark => brightness == Brightness.dark;

  factory AppDesignTheme.light({bool isTablet = false}) {
    final colors = AppDesignColors.light;
    return AppDesignTheme(
      brightness: Brightness.light,
      colors: colors,
      spacing: isTablet ? AppDesignSpacing.tablet() : AppDesignSpacing.mobile(),
      radius: AppDesignRadius.regular(),
      shadows: AppDesignShadows.fromColors(colors),
      typography: AppDesignTypography(),
    );
  }

  factory AppDesignTheme.dark({bool isTablet = false}) {
    final colors = AppDesignColors.dark;
    return AppDesignTheme(
      brightness: Brightness.dark,
      colors: colors,
      spacing: isTablet ? AppDesignSpacing.tablet() : AppDesignSpacing.mobile(),
      radius: AppDesignRadius.regular(),
      shadows: AppDesignShadows.fromColors(colors),
      typography: AppDesignTypography(),
    );
  }

  ThemeData toThemeData() {
    final textTheme = typography.toTextTheme(colors.text);
    final colorScheme = ColorScheme(
      brightness: brightness,
      primary: colors.brand,
      onPrimary: colors.inverseText,
      secondary: colors.brandAccent,
      onSecondary: colors.inverseText,
      error: colors.error,
      onError: colors.inverseText,
      surface: colors.surface,
      onSurface: colors.text,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      fontFamily: typography.fontFamily,
      scaffoldBackgroundColor: colors.background,
      primaryColor: colors.brand,
      colorScheme: colorScheme,
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        systemOverlayStyle: isDark
            ? SystemUiOverlayStyle.light
            : SystemUiOverlayStyle.dark,
        iconTheme: IconThemeData(color: colors.text),
        titleTextStyle: textTheme.titleLarge?.copyWith(color: colors.text),
      ),
      cardTheme: CardThemeData(
        color: colors.surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: radius.lgBorder),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.brand,
          foregroundColor: colors.inverseText,
          elevation: 0,
          minimumSize: Size(64.w, 48.h),
          padding: EdgeInsets.symmetric(
            horizontal: spacing.xl,
            vertical: spacing.md,
          ),
          shape: RoundedRectangleBorder(borderRadius: radius.mdBorder),
          textStyle: typography.button,
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: colors.brand,
          foregroundColor: colors.inverseText,
          minimumSize: Size(64.w, 48.h),
          shape: RoundedRectangleBorder(borderRadius: radius.mdBorder),
          textStyle: typography.button,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colors.brand,
          side: BorderSide(color: colors.brand),
          minimumSize: Size(64.w, 48.h),
          padding: EdgeInsets.symmetric(
            horizontal: spacing.xl,
            vertical: spacing.md,
          ),
          shape: RoundedRectangleBorder(borderRadius: radius.mdBorder),
          textStyle: typography.button,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colors.brand,
          padding: EdgeInsets.symmetric(
            horizontal: spacing.lg,
            vertical: spacing.sm,
          ),
          textStyle: typography.button,
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          foregroundColor: colors.text,
          shape: RoundedRectangleBorder(borderRadius: radius.mdBorder),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colors.surfaceMuted,
        contentPadding: EdgeInsets.symmetric(
          horizontal: spacing.lg,
          vertical: spacing.md,
        ),
        border: OutlineInputBorder(
          borderRadius: radius.mdBorder,
          borderSide: BorderSide(color: colors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: radius.mdBorder,
          borderSide: BorderSide(color: colors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: radius.mdBorder,
          borderSide: BorderSide(color: colors.brand, width: 1.6),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: radius.mdBorder,
          borderSide: BorderSide(color: colors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: radius.mdBorder,
          borderSide: BorderSide(color: colors.error, width: 1.6),
        ),
        hintStyle: typography.body.copyWith(color: colors.textSubtle),
        labelStyle: typography.body.copyWith(color: colors.textMuted),
        errorStyle: typography.caption.copyWith(color: colors.error),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colors.brand,
        foregroundColor: colors.inverseText,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: radius.lgBorder),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: colors.surface,
        selectedItemColor: colors.brand,
        unselectedItemColor: colors.textSubtle,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        selectedLabelStyle: typography.caption.copyWith(
          fontWeight: FontWeight.w700,
        ),
        unselectedLabelStyle: typography.caption,
      ),
      dividerTheme: DividerThemeData(color: colors.border, thickness: 1),
      chipTheme: ChipThemeData(
        backgroundColor: colors.surfaceMuted,
        selectedColor: colors.brand.withValues(alpha: 0.16),
        labelStyle: typography.caption.copyWith(color: colors.textMuted),
        shape: RoundedRectangleBorder(borderRadius: radius.smBorder),
        side: BorderSide(color: colors.border),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: colors.text,
        contentTextStyle: typography.body.copyWith(color: colors.inverseText),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: radius.mdBorder),
      ),
    );
  }
}
