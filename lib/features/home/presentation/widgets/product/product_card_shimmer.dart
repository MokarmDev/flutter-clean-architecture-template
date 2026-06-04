import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/extensions/spacing_extension.dart';
import '../../../../../shared/widgets/custom_shimmer.dart';

class ProductCardShimmer extends StatelessWidget {
  const ProductCardShimmer({super.key, this.width = 140});

  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1.02,
            child: CustomShimmer(
              width: double.infinity,
              height: double.infinity,
              borderRadius: 12.r,
            ),
          ),
          8.height,
          CustomShimmer(width: double.infinity, height: 16.h),
          4.height,
          CustomShimmer(width: double.infinity, height: 16.h),
          12.height,
          CustomShimmer(width: 80.w, height: 18.h),
        ],
      ),
    );
  }
}
