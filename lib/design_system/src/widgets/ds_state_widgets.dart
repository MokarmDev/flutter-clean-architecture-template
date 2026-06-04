import 'package:flutter/material.dart';

import '../extensions/design_context_extensions.dart';
import 'ds_button.dart';
import 'text_widget.dart';

class DsLoading extends StatelessWidget {
  const DsLoading({super.key, this.message});

  final String? message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(color: context.dsColors.brand),
          if (message?.isNotEmpty == true) ...[
            SizedBox(height: context.dsSpacing.lg),
            TextWidget(message, color: context.dsColors.textMuted),
          ],
        ],
      ),
    );
  }
}

class DsEmpty extends StatelessWidget {
  const DsEmpty({
    super.key,
    this.title = 'No data found',
    this.message,
    this.icon = Icons.inbox_outlined,
    this.actionLabel,
    this.onAction,
  });

  final String title;
  final String? message;
  final IconData icon;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return _DsStateFrame(
      icon: icon,
      iconColor: context.dsColors.textSubtle,
      title: title,
      message: message,
      actionLabel: actionLabel,
      onAction: onAction,
    );
  }
}

class DsError extends StatelessWidget {
  const DsError({
    super.key,
    this.title = 'Something went wrong',
    this.message,
    this.actionLabel = 'Try again',
    this.onAction,
  });

  final String title;
  final String? message;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return _DsStateFrame(
      icon: Icons.error_outline_rounded,
      iconColor: context.dsColors.error,
      title: title,
      message: message,
      actionLabel: actionLabel,
      onAction: onAction,
    );
  }
}

class _DsStateFrame extends StatelessWidget {
  const _DsStateFrame({
    required this.icon,
    required this.iconColor,
    required this.title,
    this.message,
    this.actionLabel,
    this.onAction,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final String? message;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(context.dsSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 54, color: iconColor),
            SizedBox(height: context.dsSpacing.lg),
            TextWidget.title(title, textAlign: TextAlign.center),
            if (message?.isNotEmpty == true) ...[
              SizedBox(height: context.dsSpacing.sm),
              TextWidget(
                message,
                color: context.dsColors.textMuted,
                textAlign: TextAlign.center,
              ),
            ],
            if (actionLabel?.isNotEmpty == true && onAction != null) ...[
              SizedBox(height: context.dsSpacing.xl),
              DsButton(label: actionLabel!, onPressed: onAction),
            ],
          ],
        ),
      ),
    );
  }
}
