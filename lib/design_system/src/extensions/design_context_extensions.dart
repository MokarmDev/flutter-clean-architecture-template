import 'package:flutter/material.dart';

import '../../design_system_app.dart';
import '../theme/app_design_theme.dart';
import '../tokens/app_design_colors.dart';
import '../tokens/app_design_radius.dart';
import '../tokens/app_design_shadows.dart';
import '../tokens/app_design_spacing.dart';
import '../tokens/app_design_typography.dart';

extension DesignContextExtensions on BuildContext {
  AppDesignTheme get ds => DesignSystemApp.of(this);
  AppDesignColors get dsColors => ds.colors;
  AppDesignSpacing get dsSpacing => ds.spacing;
  AppDesignRadius get dsRadius => ds.radius;
  AppDesignShadows get dsShadows => ds.shadows;
  AppDesignTypography get dsText => ds.typography;

  bool get isTabletLayout => MediaQuery.sizeOf(this).width >= 600;
  bool get isDesktopLayout => MediaQuery.sizeOf(this).width >= 1024;

  EdgeInsets get dsPagePadding => EdgeInsets.symmetric(
    horizontal: ds.spacing.page,
    vertical: ds.spacing.lg,
  );
}
