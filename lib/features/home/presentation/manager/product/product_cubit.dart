import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../shared/mixin/cancelable_safe_cubit_mixin.dart';
import '../../../../../shared/models/pagination/pagination_params.dart';
import '../../../domain/entities/product/product_entity.dart';
import '../../../domain/usecases/get_product_usecase.dart';
import 'product_state.dart';

class ProductCubit extends Cubit<ProductState>
    with CancelableSafeCubitMixin<ProductState> {
  final GetProductUseCase getProductUseCase;

  final List<ProductEntity> _products = [];
  List<ProductEntity> get products => List.unmodifiable(_products);

  bool hasReachedMax = false;

  ProductCubit(this.getProductUseCase) : super(ProductInitial());

  Future<void> loadProducts({int limit = 10, bool isRefresh = false}) async {
    if (isRefresh) {
      _products.clear();
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
      getProductUseCase.call(
        PaginationParams(skip: _products.length, limit: limit),
      ),
    );

    if (result == null) {
      return;
    }

    result.fold(
      (failure) {
        safeEmit(ProductError(failure.message));
      },
      (newProducts) {
        if (newProducts.isEmpty || newProducts.length < limit) {
          hasReachedMax = true;
        }
        _products.addAll(newProducts);
        safeEmit(ProductLoaded(List.from(_products)));
      },
    );
  }
}
