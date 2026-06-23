import 'package:flutter/material.dart';

import '../extensions/design_context_extensions.dart';
import 'text_widget.dart';

enum DsButtonVariant { primary, secondary, outline, ghost, danger }

class DsButton extends StatelessWidget {
  const DsButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.variant = DsButtonVariant.primary,
    this.isLoading = false,
    this.isExpanded = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final Widget? icon;
  final DsButtonVariant variant;
  final bool isLoading;
  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    final colors = context.dsColors;
    final child = _ButtonContent(
      label: label,
      icon: icon,
      isLoading: isLoading,
    );
    final effectiveOnPressed = isLoading ? null : onPressed;
    final button = switch (variant) {
      DsButtonVariant.primary => ElevatedButton(
        onPressed: effectiveOnPressed,
        child: child,
      ),
      DsButtonVariant.secondary => FilledButton(
        style: FilledButton.styleFrom(
          backgroundColor: colors.surfaceMuted,
          foregroundColor: colors.text,
        ),
        onPressed: effectiveOnPressed,
        child: child,
      ),
      DsButtonVariant.outline => OutlinedButton(
        onPressed: effectiveOnPressed,
        child: child,
      ),
      DsButtonVariant.ghost => TextButton(
        onPressed: effectiveOnPressed,
        child: child,
      ),
      DsButtonVariant.danger => ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: colors.error),
        onPressed: effectiveOnPressed,
        child: child,
      ),
    };

    if (!isExpanded) {
      return button;
    }

    return SizedBox(width: double.infinity, child: button);
  }
}

class _ButtonContent extends StatelessWidget {
  const _ButtonContent({
    required this.label,
    required this.icon,
    required this.isLoading,
  });

  final String label;
  final Widget? icon;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return SizedBox.square(
        dimension: 18,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      );
    }

    if (icon == null) {
      return TextWidget.button(
        label,
        color: DefaultTextStyle.of(context).style.color,
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        icon!,
        SizedBox(width: context.dsSpacing.sm),
        Flexible(
          child: TextWidget.button(
            label,
            color: DefaultTextStyle.of(context).style.color,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
