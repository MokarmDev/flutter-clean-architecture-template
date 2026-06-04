import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../generated/locale_keys.g.dart';
import '../../../../../shared/widgets/language_toggle_widget.dart';
import '../../../../../shared/widgets/loading_widget.dart';
import '../../../../../shared/widgets/no_data_found_widget.dart';
import '../../../../../shared/widgets/theme_toggle_widget.dart';
import '../../manager/product/product_cubit.dart';
import '../../manager/product/product_state.dart';
import 'product_card.dart';

class ProductGridView extends StatefulWidget {
  const ProductGridView({super.key});

  @override
  State<ProductGridView> createState() => _ProductGridViewState();
}

class _ProductGridViewState extends State<ProductGridView> {
  static const _pageSize = 10;
  late final ScrollController _scrollController;
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);

    // Initial fetch
    _loadFirstPage();
  }

  void _loadFirstPage() {
    context.read<ProductCubit>().loadProducts(limit: _pageSize, isRefresh: true);
  }

  void _scrollListener() async {
    final currentPosition = _scrollController.position.pixels;
    final maxScrollLength = _scrollController.position.maxScrollExtent;

    if (currentPosition >= 0.7 * maxScrollLength) {
      final cubit = context.read<ProductCubit>();
      if (!_isLoadingMore && !cubit.hasReachedMax && cubit.state is! ProductLoading) {
        setState(() {
          _isLoadingMore = true;
        });
        await cubit.loadProducts(limit: _pageSize);
        if (mounted) {
          setState(() {
            _isLoadingMore = false;
          });
        }
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.navigation_home.tr(context: context)),
        actions: const [ThemeToggleWidget(), LanguageToggleWidget()],
      ),
      body: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          final cubit = context.read<ProductCubit>();
          final products = cubit.products;

          if (state is ProductLoading && products.isEmpty) {
            return const Center(child: LoadingWidget(message: 'Loading products...'));
          } else if (state is ProductError && products.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(state.message),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _loadFirstPage,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          } else if (products.isEmpty) {
            return const Center(child: NoDataFoundWidget());
          }

          return RefreshIndicator(
            onRefresh: () async {
              await cubit.loadProducts(limit: _pageSize, isRefresh: true);
            },
            child: GridView.builder(
              controller: _scrollController,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              itemCount: products.length + (_isLoadingMore ? 1 : 0),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 0.7,
                mainAxisSpacing: 20,
                crossAxisSpacing: 16,
              ),
              itemBuilder: (context, index) {
                if (index == products.length) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: LoadingWidget(size: 24),
                    ),
                  );
                }
                return ProductCard(
                  product: products[index],
                  onPress: () {},
                );
              },
            ),
          );
        },
      ),
    );
  }
}
