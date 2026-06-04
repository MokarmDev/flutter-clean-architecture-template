import 'package:flutter/material.dart';

import '../../../../design_system/design_system.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final _couponController = TextEditingController();

  @override
  void dispose() {
    _couponController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DsScaffold(
      title: 'Cart',
      actions: [
        IconButton(
          tooltip: 'Info',
          onPressed: () => DsSnackbar.info(context, 'Cart design system demo'),
          icon: const Icon(Icons.info_outline_rounded),
        ),
      ],
      background: _CartBackground(),
      footer: DsButton(
        label: 'Checkout',
        icon: const Icon(Icons.lock_outline_rounded, size: 18),
        isExpanded: true,
        onPressed: () => DsDialog.confirm(
          context: context,
          title: 'Confirm checkout',
          message: 'This dialog uses DsDialog.confirm with two actions.',
          confirmLabel: 'Pay now',
        ),
      ),
      body: ListView(
        padding: EdgeInsets.only(bottom: context.dsSpacing.xxl * 5),
        children: [
          const TextWidget.display('Design System Cart'),
          SizedBox(height: context.dsSpacing.sm),
          TextWidget(
            'This screen intentionally uses every high-priority design system component.',
            color: context.dsColors.textMuted,
          ),
          SizedBox(height: context.dsSpacing.xl),
          _CartSummaryCard(controller: _couponController),
          SizedBox(height: context.dsSpacing.lg),
          _ButtonsShowcase(onShowBaseSheet: _showBaseSheet),
          SizedBox(height: context.dsSpacing.lg),
          const _StatesShowcase(),
          SizedBox(height: context.dsSpacing.lg),
          _FeedbackShowcase(
            onShowBaseSheet: _showBaseSheet,
            onShowFullSheet: _showFullSheet,
            onShowActionSheet: _showActionSheet,
          ),
        ],
      ),
    );
  }

  Future<void> _showBaseSheet() {
    return DsBottomSheet.show<void>(
      context: context,
      title: 'Base bottom sheet',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const TextWidget(
            'This is the reusable base sheet. It respects keyboard insets, safe areas, rounded corners, and design tokens.',
          ),
          SizedBox(height: context.dsSpacing.lg),
          DsTextField(
            label: 'Note',
            hint: 'Write anything',
            prefixIcon: const Icon(Icons.edit_note_rounded),
          ),
          SizedBox(height: context.dsSpacing.lg),
          DsButton(
            label: 'Done',
            isExpanded: true,
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  Future<void> _showFullSheet() {
    return DsBottomSheet.showFullScreen<void>(
      context: context,
      title: 'Full screen sheet',
      child: Padding(
        padding: context.dsPagePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const DsAppBar(title: 'Nested DsAppBar', showBackButton: false),
            SizedBox(height: context.dsSpacing.lg),
            const DsLoading(message: 'Loading state preview'),
            SizedBox(height: context.dsSpacing.xl),
            const DsEmpty(
              title: 'Empty section',
              message: 'Full screen sheets can host normal page content.',
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showActionSheet() async {
    final result = await DsBottomSheet.showActionSheet<String>(
      context: context,
      title: 'Action sheet',
      message: 'Pick any cart action.',
      actions: const [
        DsSheetAction(
          label: 'Apply discount',
          value: 'discount',
          icon: Icon(Icons.local_offer_outlined),
        ),
        DsSheetAction(
          label: 'Share cart',
          value: 'share',
          icon: Icon(Icons.ios_share_rounded),
        ),
        DsSheetAction(
          label: 'Clear cart',
          value: 'clear',
          icon: Icon(Icons.delete_outline_rounded),
          isDestructive: true,
        ),
      ],
    );

    if (!mounted || result == null) {
      return;
    }

    DsSnackbar.info(context, 'Selected action: $result');
  }
}

class _CartSummaryCard extends StatelessWidget {
  const _CartSummaryCard({required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return DsCard(
      showShadow: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(context.dsSpacing.md),
                decoration: BoxDecoration(
                  color: context.dsColors.brand.withValues(alpha: 0.12),
                  borderRadius: context.dsRadius.mdBorder,
                ),
                child: Icon(
                  Icons.shopping_bag_outlined,
                  color: context.dsColors.brand,
                ),
              ),
              SizedBox(width: context.dsSpacing.md),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget.title('Order summary'),
                    TextWidget.caption('DsCard + TextWidget + tokens'),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: context.dsSpacing.lg),
          DsTextField(
            controller: controller,
            label: 'Coupon code',
            hint: 'SAVE20',
            prefixIcon: const Icon(Icons.confirmation_number_outlined),
            textInputAction: TextInputAction.done,
          ),
          SizedBox(height: context.dsSpacing.lg),
          _PriceRow(label: 'Subtotal', value: '\$120.00'),
          _PriceRow(label: 'Delivery', value: '\$8.00'),
          Divider(height: context.dsSpacing.xl),
          const _PriceRow(label: 'Total', value: '\$128.00', isStrong: true),
        ],
      ),
    );
  }
}

class _PriceRow extends StatelessWidget {
  const _PriceRow({
    required this.label,
    required this.value,
    this.isStrong = false,
  });

  final String label;
  final String value;
  final bool isStrong;

  @override
  Widget build(BuildContext context) {
    final labelStyle = isStrong ? context.dsText.subtitle : context.dsText.body;

    return Padding(
      padding: EdgeInsets.only(bottom: context.dsSpacing.sm),
      child: Row(
        children: [
          Expanded(child: TextWidget(label, style: labelStyle)),
          TextWidget(value, style: labelStyle, color: context.dsColors.brand),
        ],
      ),
    );
  }
}

class _ButtonsShowcase extends StatelessWidget {
  const _ButtonsShowcase({required this.onShowBaseSheet});

  final VoidCallback onShowBaseSheet;

  @override
  Widget build(BuildContext context) {
    return DsCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const TextWidget.title('Buttons'),
          SizedBox(height: context.dsSpacing.md),
          DsButton(
            label: 'Primary',
            icon: const Icon(Icons.check_rounded, size: 18),
            onPressed: () => DsSnackbar.success(context, 'Primary action'),
          ),
          SizedBox(height: context.dsSpacing.sm),
          DsButton(
            label: 'Secondary',
            variant: DsButtonVariant.secondary,
            onPressed: onShowBaseSheet,
          ),
          SizedBox(height: context.dsSpacing.sm),
          DsButton(
            label: 'Outline',
            variant: DsButtonVariant.outline,
            onPressed: () => DsSnackbar.warning(context, 'Outline action'),
          ),
          SizedBox(height: context.dsSpacing.sm),
          DsButton(
            label: 'Ghost',
            variant: DsButtonVariant.ghost,
            onPressed: () => DsSnackbar.info(context, 'Ghost action'),
          ),
          SizedBox(height: context.dsSpacing.sm),
          DsButton(
            label: 'Danger',
            variant: DsButtonVariant.danger,
            onPressed: () => DsDialog.confirm(
              context: context,
              title: 'Remove item?',
              message: 'This shows the destructive confirm style.',
              confirmLabel: 'Remove',
              isDestructive: true,
            ),
          ),
          SizedBox(height: context.dsSpacing.sm),
          const DsButton(label: 'Loading', onPressed: null, isLoading: true),
        ],
      ),
    );
  }
}

class _StatesShowcase extends StatelessWidget {
  const _StatesShowcase();

  @override
  Widget build(BuildContext context) {
    return DsCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const TextWidget.title('State widgets'),
          SizedBox(height: context.dsSpacing.md),
          SizedBox(height: 120, child: DsLoading(message: 'DsLoading')),
          Divider(height: context.dsSpacing.xl),
          const DsEmpty(
            title: 'DsEmpty',
            message: 'Reusable empty state for pages and lists.',
            actionLabel: 'Refresh',
          ),
          Divider(height: context.dsSpacing.xl),
          DsError(
            title: 'DsError',
            message: 'Reusable error state with optional retry.',
            onAction: () => DsSnackbar.error(context, 'Retry tapped'),
          ),
        ],
      ),
    );
  }
}

class _FeedbackShowcase extends StatelessWidget {
  const _FeedbackShowcase({
    required this.onShowBaseSheet,
    required this.onShowFullSheet,
    required this.onShowActionSheet,
  });

  final VoidCallback onShowBaseSheet;
  final VoidCallback onShowFullSheet;
  final VoidCallback onShowActionSheet;

  @override
  Widget build(BuildContext context) {
    return DsCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const TextWidget.title('Overlays and feedback'),
          SizedBox(height: context.dsSpacing.md),
          Wrap(
            spacing: context.dsSpacing.sm,
            runSpacing: context.dsSpacing.sm,
            children: [
              DsButton(
                label: 'Success',
                onPressed: () => DsSnackbar.success(context, 'Saved'),
              ),
              DsButton(
                label: 'Error',
                variant: DsButtonVariant.danger,
                onPressed: () => DsSnackbar.error(context, 'Failed'),
              ),
              DsButton(
                label: 'Alert',
                variant: DsButtonVariant.outline,
                onPressed: () => DsDialog.alert(
                  context: context,
                  title: 'Alert dialog',
                  message: 'This uses DsDialog.alert.',
                ),
              ),
              DsButton(
                label: 'Confirm',
                variant: DsButtonVariant.secondary,
                onPressed: () => DsDialog.confirm(
                  context: context,
                  title: 'Confirm dialog',
                  message: 'This uses DsDialog.confirm.',
                ),
              ),
            ],
          ),
          SizedBox(height: context.dsSpacing.md),
          DsButton(
            label: 'Base bottom sheet',
            icon: const Icon(Icons.keyboard_arrow_up_rounded, size: 18),
            onPressed: onShowBaseSheet,
          ),
          SizedBox(height: context.dsSpacing.sm),
          DsButton(
            label: 'Full screen sheet',
            variant: DsButtonVariant.secondary,
            icon: const Icon(Icons.open_in_full_rounded, size: 18),
            onPressed: onShowFullSheet,
          ),
          SizedBox(height: context.dsSpacing.sm),
          DsButton(
            label: 'Action sheet',
            variant: DsButtonVariant.outline,
            icon: const Icon(Icons.more_horiz_rounded, size: 18),
            onPressed: onShowActionSheet,
          ),
        ],
      ),
    );
  }
}

class _CartBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            context.dsColors.brand.withValues(alpha: 0.10),
            context.dsColors.background,
            context.dsColors.background,
          ],
        ),
      ),
    );
  }
}
