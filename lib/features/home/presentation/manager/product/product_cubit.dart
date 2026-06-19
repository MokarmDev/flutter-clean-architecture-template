import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../shared/mixin/cancelable_safe_cubit_mixin.dart';
import '../../../domain/entities/product/product_entity.dart';
import '../../../domain/usecases/get_product_usecase.dart';
import 'product_state.dart';

class ProductCubit extends Cubit<ProductState>
    with CancelableSafeCubitMixin<ProductState> {
  final GetProductUseCase getProductUseCase;

  final List<ProductEntity> _products = [];
  List<ProductEntity> get products => List.unmodifiable(_products);

  bool hasReachedMax = false;
  int _nextPage = 0;
  final int _pageSize = 10;

  ProductCubit(this.getProductUseCase) : super(ProductInitial());

  Future<void> loadProducts({bool isRefresh = false}) async {
    if (isRefresh) {
      _products.clear();
      _nextPage = 0;
      hasReachedMax = false;
      safeEmit(ProductInitial());
    }

    if (hasReachedMax) {
      return;
    }

    if (_products.isEmpty) {
      safeEmit(ProductLoading());
    }

    final result = await runCancelable(
      getProductUseCase.call(page: _nextPage, pageSize: _pageSize),
    );
    if (result == null) return;

    result.fold((failure) => safeEmit(ProductError(failure.message)), (
      response,
    ) {
      _products.addAll(response.data);
      if (!response.hasNextPage) hasReachedMax = true;
      _nextPage++;
      safeEmit(ProductLoaded(List.from(_products)));
    });
  }
}
