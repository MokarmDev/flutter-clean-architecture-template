import 'package:flutter/widgets.dart';

extension SliverExtensions on Widget {
  SliverToBoxAdapter toSliver() => SliverToBoxAdapter(child: this);

  SliverToBoxAdapter toAnimatedSliver({
    Duration duration = const Duration(milliseconds: 300),
    AnimatedSwitcherTransitionBuilder? transitionBuilder,
    Key? key,
  }) {
    return SliverToBoxAdapter(
      child: AnimatedSwitcher(
        duration: duration,
        transitionBuilder:
            transitionBuilder ?? AnimatedSwitcher.defaultTransitionBuilder,
        key: key,
        child: this,
      ),
    );
  }
}
