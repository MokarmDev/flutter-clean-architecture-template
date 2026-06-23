import 'package:flutter/material.dart';

import '../extensions/design_context_extensions.dart';
import 'ds_button.dart';
import 'text_widget.dart';

class DsDialog {
  const DsDialog._();

  static Future<void> alert({
    required BuildContext context,
    required String title,
    String? message,
    String confirmLabel = 'OK',
    VoidCallback? onConfirm,
  }) {
    return showDialog<void>(
      context: context,
      builder: (context) => _DsDialogFrame(
        title: title,
        message: message,
        actions: [
          DsButton(
            label: confirmLabel,
            isExpanded: true,
            onPressed: () {
              Navigator.pop(context);
              onConfirm?.call();
            },
          ),
        ],
      ),
    );
  }

  static Future<bool?> confirm({
    required BuildContext context,
    required String title,
    String? message,
    String confirmLabel = 'Confirm',
    String cancelLabel = 'Cancel',
    bool isDestructive = false,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (context) => _DsDialogFrame(
        title: title,
        message: message,
        actions: [
          Row(
            children: [
              Expanded(
                child: DsButton(
                  label: cancelLabel,
                  variant: DsButtonVariant.secondary,
                  onPressed: () => Navigator.pop(context, false),
                ),
              ),
              SizedBox(width: context.dsSpacing.md),
              Expanded(
                child: DsButton(
                  label: confirmLabel,
                  variant: isDestructive
                      ? DsButtonVariant.danger
                      : DsButtonVariant.primary,
                  onPressed: () => Navigator.pop(context, true),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DsDialogFrame extends StatelessWidget {
  const _DsDialogFrame({
    required this.title,
    required this.actions,
    this.message,
  });

  final String title;
  final String? message;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.all(context.dsSpacing.xl),
      backgroundColor: context.dsColors.surface,
      shape: RoundedRectangleBorder(borderRadius: context.dsRadius.lgBorder),
      child: Padding(
        padding: EdgeInsets.all(context.dsSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextWidget.title(title, textAlign: TextAlign.center),
            if (message?.isNotEmpty == true) ...[
              SizedBox(height: context.dsSpacing.md),
              TextWidget(
                message,
                color: context.dsColors.textMuted,
                textAlign: TextAlign.center,
              ),
            ],
            SizedBox(height: context.dsSpacing.xl),
            ...actions,
          ],
        ),
      ),
    );
  }
}
