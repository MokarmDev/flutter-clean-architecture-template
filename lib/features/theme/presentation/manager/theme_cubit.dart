import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/theme_entity.dart';
import '../../domain/usecases/get_theme_usecase.dart';
import '../../domain/usecases/save_theme_usecase.dart';
import 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  final GetThemeUseCase getThemeUseCase;
  final SaveThemeUseCase saveThemeUseCase;

  ThemeCubit({
    required this.getThemeUseCase,
    required this.saveThemeUseCase,
  }) : super(ThemeInitial());

  Future<void> loadData() async {
    emit(ThemeLoading());
    try {
      final theme = await getThemeUseCase();
      emit(ThemeSuccess(theme));
    } catch (e) {
      emit(ThemeError(e.toString()));
    }
  }

  Future<void> toggleTheme() async {
    if (state is ThemeSuccess) {
      final currentThemeType = (state as ThemeSuccess).theme.type;
      final newThemeType = currentThemeType == ThemeType.light
          ? ThemeType.dark
          : ThemeType.light;
      
      final newTheme = ThemeEntity(type: newThemeType);
      
      try {
        await saveThemeUseCase(newTheme);
        emit(ThemeSuccess(newTheme));
      } catch (e) {
        emit(ThemeError(e.toString()));
      }
    }
  }
}
