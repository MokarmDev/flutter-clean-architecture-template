import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/theme/app_colors.dart';
import '../../features/theme/domain/entities/theme_entity.dart';
import '../../features/theme/presentation/manager/theme_cubit.dart';
import '../../features/theme/presentation/manager/theme_state.dart';

class ThemeToggleWidget extends StatelessWidget {
  const ThemeToggleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        if (state is ThemeSuccess) {
          final isDark = state.theme.type == ThemeType.dark;
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (child, anim) => RotationTransition(
              turns: child.key == const ValueKey('theme_icon_dark')
                  ? Tween<double>(begin: 1, end: 0).animate(anim)
                  : Tween<double>(begin: 0.75, end: 1).animate(anim),
              child: FadeTransition(
                opacity: anim,
                child: ScaleTransition(scale: anim, child: child),
              ),
            ),
            child: IconButton(
              key: ValueKey(isDark ? 'theme_icon_dark' : 'theme_icon_light'),
              icon: Icon(
                isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                color: isDark
                    ? AppColors.primaryLight
                    : AppColors.black,
              ),
              onPressed: () {
                context.read<ThemeCubit>().toggleTheme();
              },
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
