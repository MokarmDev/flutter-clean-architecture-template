import 'package:async/async.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

mixin CancelableSafeCubitMixin<S>
    on Cubit<S> {

  CancelableOperation? _operation;

  Future<T?> runCancelable<T>(
    Future<T> future,
  ) async {
    await _operation?.cancel();

    _operation =
        CancelableOperation.fromFuture(
      future,
    );

    final result =
        await _operation!.valueOrCancellation();

    if (isClosed) {
      return null;
    }

    return result;
  }

  void safeEmit(S state) {
    if (!isClosed) {
      emit(state);
    }
  }

  @override
  Future<void> close() async {
    await _operation?.cancel();
    return super.close();
  }
}