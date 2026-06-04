import 'package:flutter_bloc/flutter_bloc.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  Future<void> loadData() async {
    emit(CartLoading());
    // TODO: implement logic
    emit(CartLoaded());
  }
}
