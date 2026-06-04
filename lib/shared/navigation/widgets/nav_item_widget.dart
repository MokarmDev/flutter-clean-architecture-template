import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/extensions/spacing_extension.dart';
import '../../../core/extensions/widget_extensions.dart';
import '../nav_enum.dart';

class NavItemWidget extends StatelessWidget {
  final NavEnum tab;
  final bool isSelected;
  final VoidCallback onTap;

  const NavItemWidget({
    super.key,
    required this.tab,
    required this.isSelected,
    required this.onTap,
  });

  static const _duration = Duration(milliseconds: 250);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final activeColor = colorScheme.primary;
    final inactiveColor = colorScheme.onSurface.withValues(alpha: 0.5);

    return InkWell(
      borderRadius: BorderRadius.circular(25.r),
      onTap: onTap,
      child: AnimatedContainer(
        duration: _duration,
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedScale(
              duration: _duration,
              scale: isSelected ? 1.15 : 1.0,
              child: AnimatedContainer(
                duration: _duration,
                width: 30.w,
                height: 28.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: isSelected
                      ? activeColor.withValues(alpha: 0.08)
                      : Colors.transparent,
                ),
                alignment: Alignment.center,
                child: Icon(
                  tab.icon,
                  size: 24.sp,
                  color: isSelected ? activeColor : inactiveColor,
                ),
              ),
            ),
            4.height,
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: context.title.copyWith(
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: isSelected ? activeColor : inactiveColor,
                fontSize: isSelected ? 12.sp : 11.sp,
              ),
              child: Text(
                tab.title.tr(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
