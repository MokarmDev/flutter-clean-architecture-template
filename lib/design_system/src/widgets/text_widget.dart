import 'package:flutter/material.dart';

import '../extensions/design_context_extensions.dart';

class TextWidget extends StatelessWidget {
  const TextWidget(
    this.text, {
    super.key,
    this.style,
    this.color,
    this.textAlign,
    this.textDirection,
    this.maxLines,
    this.overflow,
    this.textScaler,
    this.softWrap,
  }) : _variant = _TextWidgetVariant.body;

  const TextWidget.display(
    this.text, {
    super.key,
    this.style,
    this.color,
    this.textAlign,
    this.textDirection,
    this.maxLines,
    this.overflow,
    this.textScaler,
    this.softWrap,
  }) : _variant = _TextWidgetVariant.display;

  const TextWidget.headline(
    this.text, {
    super.key,
    this.style,
    this.color,
    this.textAlign,
    this.textDirection,
    this.maxLines,
    this.overflow,
    this.textScaler,
    this.softWrap,
  }) : _variant = _TextWidgetVariant.headline;

  const TextWidget.title(
    this.text, {
    super.key,
    this.style,
    this.color,
    this.textAlign,
    this.textDirection,
    this.maxLines,
    this.overflow,
    this.textScaler,
    this.softWrap,
  }) : _variant = _TextWidgetVariant.title;

  const TextWidget.subtitle(
    this.text, {
    super.key,
    this.style,
    this.color,
    this.textAlign,
    this.textDirection,
    this.maxLines,
    this.overflow,
    this.textScaler,
    this.softWrap,
  }) : _variant = _TextWidgetVariant.subtitle;

  const TextWidget.caption(
    this.text, {
    super.key,
    this.style,
    this.color,
    this.textAlign,
    this.textDirection,
    this.maxLines,
    this.overflow,
    this.textScaler,
    this.softWrap,
  }) : _variant = _TextWidgetVariant.caption;

  const TextWidget.button(
    this.text, {
    super.key,
    this.style,
    this.color,
    this.textAlign,
    this.textDirection,
    this.maxLines,
    this.overflow,
    this.textScaler,
    this.softWrap,
  }) : _variant = _TextWidgetVariant.button;

  final String? text;
  final TextStyle? style;
  final Color? color;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextScaler? textScaler;
  final bool? softWrap;
  final _TextWidgetVariant _variant;

  @override
  Widget build(BuildContext context) {
    if (text?.trim().isNotEmpty != true) {
      return const SizedBox.shrink();
    }

    final defaultStyle = switch (_variant) {
      _TextWidgetVariant.display => context.dsText.display,
      _TextWidgetVariant.headline => context.dsText.headline,
      _TextWidgetVariant.title => context.dsText.title,
      _TextWidgetVariant.subtitle => context.dsText.subtitle,
      _TextWidgetVariant.body => context.dsText.body,
      _TextWidgetVariant.caption => context.dsText.caption,
      _TextWidgetVariant.button => context.dsText.button,
    };

    return Text(
      text!,
      style: (style ?? defaultStyle).copyWith(
        color: color ?? style?.color ?? context.dsColors.text,
      ),
      overflow: overflow ?? (maxLines == 1 ? TextOverflow.ellipsis : null),
      textAlign: textAlign,
      textDirection: textDirection,
      maxLines: maxLines,
      textScaler: textScaler ?? TextScaler.noScaling,
      softWrap: softWrap,
    );
  }
}

enum _TextWidgetVariant {
  display,
  headline,
  title,
  subtitle,
  body,
  caption,
  button,
}
