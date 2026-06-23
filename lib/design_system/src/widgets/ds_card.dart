import 'package:flutter/material.dart';

import '../extensions/design_context_extensions.dart';

class DsCard extends StatelessWidget {
  const DsCard({
    super.key,
    required this.child,
    this.padding,
    this.onTap,
    this.showBorder = true,
    this.showShadow = false,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;
  final bool showBorder;
  final bool showShadow;

  @override
  Widget build(BuildContext context) {
    final colors = context.dsColors;
    final radius = context.dsRadius;
    final content = DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: radius.lgBorder,
        border: showBorder ? Border.all(color: colors.border) : null,
        boxShadow: showShadow ? context.dsShadows.card : null,
      ),
      child: Padding(
        padding: padding ?? EdgeInsets.all(context.dsSpacing.lg),
        child: child,
      ),
    );

    if (onTap == null) {
      return content;
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: radius.lgBorder,
        onTap: onTap,
        child: content,
      ),
    );
  }
}
