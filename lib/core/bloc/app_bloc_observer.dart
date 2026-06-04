import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../utils/logger.dart';

/// Observes BLoC/Cubit lifecycle and transitions without flooding the debug console.
class AppBlocObserver extends BlocObserver {
  /// Logs full `state`/`event` via `toString()`. Very noisy; dev only.
  static const bool verboseChanges = false;

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    if (!kDebugMode) return;

    if (verboseChanges) {
      AppLogger.info(
        'Change ${bloc.runtimeType}: ${change.currentState} → ${change.nextState}',
      );
      return;
    }

    AppLogger.info(
      'Change ${bloc.runtimeType}: '
      '${_typeLabel(change.currentState)} → ${_typeLabel(change.nextState)}',
    );
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    if (!kDebugMode) return;
    AppLogger.info('Bloc closed: ${bloc.runtimeType}');
  }

  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    if (!kDebugMode) return;
    AppLogger.info('Bloc created: ${bloc.runtimeType}');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    if (!kDebugMode) return;
    AppLogger.error('Error in ${bloc.runtimeType}', error, stackTrace);
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    if (!kDebugMode) return;
    final label = verboseChanges ? '$event' : _typeLabel(event);
    AppLogger.info('Event ${bloc.runtimeType}: $label');
  }

  static String _typeLabel(Object? value) {
    if (value == null) return 'null';
    return value.runtimeType.toString();
  }
}
