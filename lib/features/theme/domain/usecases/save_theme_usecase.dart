import '../entities/theme_entity.dart';
import '../repositories/theme_repository.dart';

class SaveThemeUseCase {
  final ThemeRepository repository;

  SaveThemeUseCase(this.repository);

  Future<void> call(ThemeEntity theme) async {
    await repository.saveTheme(theme);
  }
}