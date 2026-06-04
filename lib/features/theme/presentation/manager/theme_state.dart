import 'package:equatable/equatable.dart';

import '../../domain/entities/theme_entity.dart';

abstract class ThemeState extends Equatable {
  const ThemeState();

  @override
  List<Object> get props => [];
}

class ThemeInitial extends ThemeState {}

class ThemeLoading extends ThemeState {}

class ThemeSuccess extends ThemeState {
  final ThemeEntity theme;
  const ThemeSuccess(this.theme);
  @override
  List<Object> get props => [theme];
}

class ThemeError extends ThemeState {
  final String message;
  const ThemeError(this.message);
  @override
  List<Object> get props => [message];
}
