import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures.dart';
import '../../../../../shared/models/pagination/pagination_params.dart';
import '../../../domain/entities/product/product_entity.dart';
import '../../../domain/usecases/get_product_usecase.dart';
import 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final GetProductUseCase getProductUseCase;

  final List<ProductEntity> _products = [];
  List<ProductEntity> get products => List.unmodifiable(_products);

  bool hasReachedMax = false;

  ProductCubit(this.getProductUseCase) : super(ProductInitial());

  Future<Either<Failure, List<ProductEntity>>> loadProducts({
    int limit = 10,
    bool isRefresh = false,
  }) async {
    if (isRefresh) {
      _products.clear();
      hasReachedMax = false;
      emit(ProductInitial());
    }

    if (hasReachedMax) {
      return Right(_products);
    }

    if (_products.isEmpty) {
      emit(ProductLoading());
    }

    final result = await getProductUseCase.call(
      PaginationParams(skip: _products.length, limit: limit),
    );

    return result.fold(
      (failure) {
        emit(ProductError(failure.message));
        return Left(failure);
      },
      (newProducts) {
        if (newProducts.isEmpty || newProducts.length < limit) {
          hasReachedMax = true;
        }
        _products.addAll(newProducts);
        emit(ProductLoaded(List.from(_products)));
        return Right(_products);
      },
    );
  }
}
