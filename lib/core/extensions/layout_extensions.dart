import 'package:flutter/material.dart';

extension PaddingExtension on Widget {
  Widget padding([EdgeInsetsGeometry value = const EdgeInsets.all(8)]) =>
      Padding(padding: value, child: this);

  Widget paddingHorizontal([double value = 8]) => Padding(
    padding: EdgeInsets.symmetric(horizontal: value),
    child: this,
  );

  Widget paddingVertical([double value = 8]) => Padding(
    padding: EdgeInsets.symmetric(vertical: value),
    child: this,
  );
}

extension ExpandedExtension on Widget {
  Widget expanded({int flex = 1}) => Expanded(flex: flex, child: this);
}

extension VisibilityExtension on Widget {
  Widget visible(bool isVisible) => isVisible ? this : const SizedBox.shrink();
}

extension MarginExtension on Widget {
  Widget margin([EdgeInsetsGeometry value = const EdgeInsets.all(8)]) =>
      Container(margin: value, child: this);
}

extension AlignExtension on Widget {
  Widget align([Alignment alignment = Alignment.center]) =>
      Align(alignment: alignment, child: this);
}

extension SafeAreaExtension on Widget {
  Widget withSafeArea({
    bool top = true,
    bool bottom = true,
    bool left = true,
    bool right = true,
  }) =>
      SafeArea(top: top, bottom: bottom, left: left, right: right, child: this);
}

extension CenterExtension on Widget {
  Widget center() => Center(child: this);
}
