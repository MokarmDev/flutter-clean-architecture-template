import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/extensions/layout_extensions.dart';
import '../../../../../core/extensions/spacing_extension.dart';
import '../../../../../core/extensions/widget_extensions.dart';
import '../../../../../shared/widgets/custom_network_image.dart';
import '../../../domain/entities/product/product_entity.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    this.width = 140,
    this.aspectRetio = 1.02,
    required this.product,
    required this.onPress,
  });

  final double width, aspectRetio;
  final ProductEntity product;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width.w,
      child: GestureDetector(
        onTap: onPress,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1.02,
              child: Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: context.theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: CustomNetworkImage(imageUrl: product.images[0]),
              ),
            ),
            8.height,
            Text(product.title, style: context.text.bodyMedium, maxLines: 2),
            Text(
              '\$${product.price}',
              style: context.body.copyWith(
                color: context.colors.primary,
                fontWeight: FontWeight.w600,
              ),
            ).expanded(),
          ],
        ),
      ),
    );
  }
}
