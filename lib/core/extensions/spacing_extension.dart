import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../config/theme/app_colors.dart';

extension SpacingExtension on num {
  SizedBox get width => SizedBox(width: w);
  SizedBox get height => SizedBox(height: h);

  Widget get hDivider => SizedBox(
    height: h,
    child: Divider(height: 0.h, color: AppColors.divider),
  );

  Widget get vDivider => SizedBox(
    width: w,
    child: VerticalDivider(width: 0.w, color: AppColors.divider),
  );
}
