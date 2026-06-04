import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../extensions/design_context_extensions.dart';
import 'ds_app_bar.dart';

class DsScaffold extends StatelessWidget {
  const DsScaffold({
    super.key,
    required this.body,
    this.title,
    this.appBar,
    this.actions,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.footer,
    this.background,
    this.backgroundColor,
    this.statusBarColor,
    this.statusBarIconBrightness,
    this.systemNavigationBarColor,
    this.systemNavigationBarIconBrightness,
    this.dismissKeyboardOnTap = true,
    this.safeArea = true,
    this.useTopSafeArea = true,
    this.useBottomSafeArea = true,
    this.withPagePadding = true,
    this.resizeToAvoidBottomInset,
  });

  final Widget body;
  final String? title;
  final PreferredSizeWidget? appBar;
  final List<Widget>? actions;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final Widget? footer;
  final Widget? background;
  final Color? backgroundColor;
  final Color? statusBarColor;
  final Brightness? statusBarIconBrightness;
  final Color? systemNavigationBarColor;
  final Brightness? systemNavigationBarIconBrightness;
  final bool dismissKeyboardOnTap;
  final bool safeArea;
  final bool useTopSafeArea;
  final bool useBottomSafeArea;
  final bool withPagePadding;
  final bool? resizeToAvoidBottomInset;

  @override
  Widget build(BuildContext context) {
    final colors = context.dsColors;
    final isDark = context.ds.isDark;
    Widget content = body;

    if (withPagePadding) {
      content = Padding(padding: context.dsPagePadding, child: content);
    }

    if (safeArea) {
      content = SafeArea(
        top: useTopSafeArea,
        bottom: useBottomSafeArea,
        child: content,
      );
    }

    if (dismissKeyboardOnTap) {
      content = GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: content,
      );
    }

    final scaffold = AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: statusBarColor ?? Colors.transparent,
        statusBarIconBrightness:
            statusBarIconBrightness ??
            (isDark ? Brightness.light : Brightness.dark),
        statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
        systemNavigationBarColor:
            systemNavigationBarColor ?? backgroundColor ?? colors.background,
        systemNavigationBarIconBrightness:
            systemNavigationBarIconBrightness ??
            (isDark ? Brightness.light : Brightness.dark),
      ),
      child: Scaffold(
        appBar:
            appBar ??
            (title == null ? null : DsAppBar(title: title, actions: actions)),
        backgroundColor: backgroundColor ?? colors.background,
        body: Stack(fit: StackFit.expand, children: [?background, content]),
        bottomNavigationBar: bottomNavigationBar,
        floatingActionButton: floatingActionButton,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      ),
    );

    if (footer == null) {
      return scaffold;
    }

    return Stack(
      children: [
        scaffold,
        Positioned(
          left: context.dsSpacing.page,
          right: context.dsSpacing.page,
          bottom: MediaQuery.paddingOf(context).bottom + context.dsSpacing.lg,
          child: footer!,
        ),
      ],
    );
  }
}
