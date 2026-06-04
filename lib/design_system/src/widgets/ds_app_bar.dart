import 'package:flutter/material.dart';

import '../extensions/design_context_extensions.dart';
import 'text_widget.dart';

class DsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DsAppBar({
    super.key,
    this.title,
    this.leading,
    this.actions,
    this.centerTitle = true,
    this.showBackButton = true,
    this.onBack,
    this.backgroundColor,
    this.foregroundColor,
    this.bottom,
  });

  final String? title;
  final Widget? leading;
  final List<Widget>? actions;
  final bool centerTitle;
  final bool showBackButton;
  final VoidCallback? onBack;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final PreferredSizeWidget? bottom;

  @override
  Size get preferredSize {
    final bottomHeight = bottom?.preferredSize.height ?? 0;
    return Size.fromHeight(kToolbarHeight + bottomHeight);
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.dsColors;

    return AppBar(
      backgroundColor: backgroundColor ?? Colors.transparent,
      foregroundColor: foregroundColor ?? colors.text,
      centerTitle: centerTitle,
      elevation: 0,
      scrolledUnderElevation: 0,
      leading: leading ?? _buildBackButton(context),
      title: TextWidget.title(
        title,
        color: foregroundColor ?? colors.text,
        maxLines: 1,
        textAlign: TextAlign.center,
      ),
      actions: actions,
      bottom: bottom,
    );
  }

  Widget? _buildBackButton(BuildContext context) {
    if (!showBackButton || !Navigator.canPop(context)) {
      return null;
    }

    return IconButton(
      onPressed: onBack ?? () => Navigator.maybePop(context),
      icon: const Icon(Icons.arrow_back_ios_new_rounded),
    );
  }
}
