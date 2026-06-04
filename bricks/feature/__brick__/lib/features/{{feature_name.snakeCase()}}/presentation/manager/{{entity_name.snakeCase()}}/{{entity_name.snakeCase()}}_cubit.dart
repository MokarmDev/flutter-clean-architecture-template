import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../shared/mixin/cancelable_safe_cubit_mixin.dart';
import '../../../domain/usecases/get_{{entity_name.snakeCase()}}s_usecase.dart';
import '{{entity_name.snakeCase()}}_state.dart';

class {{entity_name.pascalCase()}}Cubit extends Cubit<{{entity_name.pascalCase()}}State>
    with CancelableSafeCubitMixin<{{entity_name.pascalCase()}}State> {
  final Get{{entity_name.pascalCase()}}sUseCase _get{{entity_name.pascalCase()}}sUseCase;

  {{entity_name.pascalCase()}}Cubit(this._get{{entity_name.pascalCase()}}sUseCase)
      : super({{entity_name.pascalCase()}}Initial());

  Future<void> loadData() async {
    safeEmit({{entity_name.pascalCase()}}Loading());

    final result = await runCancelable(
      _get{{entity_name.pascalCase()}}sUseCase.call(),
    );

    if (result == null) return;

    result.fold(
      (failure) => safeEmit({{entity_name.pascalCase()}}Error(failure.message)),
      (items) => safeEmit({{entity_name.pascalCase()}}Loaded(items)),
    );
  }
}
