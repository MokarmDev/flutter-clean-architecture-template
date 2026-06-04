import 'package:flutter/material.dart';

import '../extensions/design_context_extensions.dart';
import 'text_widget.dart';

class DsBottomSheet {
  const DsBottomSheet._();

  static Future<T?> show<T>({
    required BuildContext context,
    required Widget child,
    String? title,
    bool isDismissible = true,
    bool enableDrag = true,
    bool useSafeArea = true,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      useSafeArea: useSafeArea,
      backgroundColor: Colors.transparent,
      builder: (context) => _DsBottomSheetFrame(title: title, child: child),
    );
  }

  static Future<T?> showFullScreen<T>({
    required BuildContext context,
    required Widget child,
    String? title,
    List<Widget>? actions,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (context) =>
          _DsFullScreenSheet(title: title, actions: actions, child: child),
    );
  }

  static Future<T?> showActionSheet<T>({
    required BuildContext context,
    required List<DsSheetAction<T>> actions,
    String? title,
    String? message,
    bool showCancel = true,
  }) {
    return show<T>(
      context: context,
      title: title,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (message?.isNotEmpty == true) ...[
            TextWidget(message, color: context.dsColors.textMuted),
            SizedBox(height: context.dsSpacing.lg),
          ],
          ...actions.map((action) => _DsActionTile(action: action)),
          if (showCancel) ...[
            SizedBox(height: context.dsSpacing.sm),
            DsSheetActionTile(
              label: MaterialLocalizations.of(context).cancelButtonLabel,
              onTap: () => Navigator.pop(context),
            ),
          ],
        ],
      ),
    );
  }
}

class DsSheetAction<T> {
  const DsSheetAction({
    required this.label,
    this.value,
    this.icon,
    this.isDestructive = false,
    this.onTap,
  });

  final String label;
  final T? value;
  final Widget? icon;
  final bool isDestructive;
  final VoidCallback? onTap;
}

class DsSheetActionTile extends StatelessWidget {
  const DsSheetActionTile({
    super.key,
    required this.label,
    required this.onTap,
    this.icon,
    this.isDestructive = false,
  });

  final String label;
  final VoidCallback onTap;
  final Widget? icon;
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    final colors = context.dsColors;
    final textColor = isDestructive ? colors.error : colors.text;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: context.dsRadius.mdBorder,
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.dsSpacing.md,
            vertical: context.dsSpacing.md,
          ),
          child: Row(
            children: [
              if (icon != null) ...[
                IconTheme(
                  data: IconThemeData(color: textColor, size: 22),
                  child: icon!,
                ),
                SizedBox(width: context.dsSpacing.md),
              ],
              Expanded(child: TextWidget.subtitle(label, color: textColor)),
            ],
          ),
        ),
      ),
    );
  }
}

class _DsBottomSheetFrame extends StatelessWidget {
  const _DsBottomSheetFrame({required this.child, this.title});

  final Widget child;
  final String? title;

  @override
  Widget build(BuildContext context) {
    final colors = context.dsColors;
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;
    final maxHeight = MediaQuery.sizeOf(context).height * 0.9;

    return Padding(
      padding: EdgeInsets.only(bottom: bottomInset),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: maxHeight),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.vertical(top: context.dsRadius.xl),
            boxShadow: context.dsShadows.overlay,
          ),
          child: SafeArea(
            top: false,
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                context.dsSpacing.page,
                context.dsSpacing.md,
                context.dsSpacing.page,
                context.dsSpacing.lg,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Container(
                      width: 42,
                      height: 4,
                      decoration: BoxDecoration(
                        color: colors.border,
                        borderRadius: context.dsRadius.pillBorder,
                      ),
                    ),
                  ),
                  if (title?.isNotEmpty == true) ...[
                    SizedBox(height: context.dsSpacing.lg),
                    TextWidget.title(title, textAlign: TextAlign.center),
                  ],
                  SizedBox(height: context.dsSpacing.lg),
                  Flexible(
                    child: SingleChildScrollView(
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      child: child,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DsFullScreenSheet extends StatelessWidget {
  const _DsFullScreenSheet({required this.child, this.title, this.actions});

  final Widget child;
  final String? title;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.dsColors.background,
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.dsSpacing.sm),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close_rounded),
                  ),
                  Expanded(
                    child: TextWidget.title(
                      title,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                    ),
                  ),
                  ...?actions,
                ],
              ),
            ),
            Expanded(child: child),
          ],
        ),
      ),
    );
  }
}

class _DsActionTile<T> extends StatelessWidget {
  const _DsActionTile({required this.action});

  final DsSheetAction<T> action;

  @override
  Widget build(BuildContext context) {
    return DsSheetActionTile(
      label: action.label,
      icon: action.icon,
      isDestructive: action.isDestructive,
      onTap: () {
        action.onTap?.call();
        Navigator.pop(context, action.value);
      },
    );
  }
}
