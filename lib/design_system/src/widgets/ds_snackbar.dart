import 'package:flutter/material.dart';

import '../extensions/design_context_extensions.dart';
import 'text_widget.dart';

enum DsFeedbackType { success, error, warning, info }

class DsSnackbar {
  const DsSnackbar._();

  static void success(BuildContext context, String message) {
    show(context, message: message, type: DsFeedbackType.success);
  }

  static void error(BuildContext context, String message) {
    show(context, message: message, type: DsFeedbackType.error);
  }

  static void warning(BuildContext context, String message) {
    show(context, message: message, type: DsFeedbackType.warning);
  }

  static void info(BuildContext context, String message) {
    show(context, message: message, type: DsFeedbackType.info);
  }

  static void show(
    BuildContext context, {
    required String message,
    DsFeedbackType type = DsFeedbackType.info,
    Duration duration = const Duration(seconds: 3),
  }) {
    final colors = context.dsColors;
    final backgroundColor = switch (type) {
      DsFeedbackType.success => colors.success,
      DsFeedbackType.error => colors.error,
      DsFeedbackType.warning => colors.warning,
      DsFeedbackType.info => colors.info,
    };
    final icon = switch (type) {
      DsFeedbackType.success => Icons.check_circle_outline_rounded,
      DsFeedbackType.error => Icons.error_outline_rounded,
      DsFeedbackType.warning => Icons.warning_amber_rounded,
      DsFeedbackType.info => Icons.info_outline_rounded,
    };

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          duration: duration,
          backgroundColor: backgroundColor,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: context.dsRadius.mdBorder,
          ),
          content: Row(
            children: [
              Icon(icon, color: colors.inverseText),
              SizedBox(width: context.dsSpacing.md),
              Expanded(
                child: TextWidget(
                  message,
                  color: colors.inverseText,
                  maxLines: 3,
                ),
              ),
            ],
          ),
        ),
      );
  }
}
