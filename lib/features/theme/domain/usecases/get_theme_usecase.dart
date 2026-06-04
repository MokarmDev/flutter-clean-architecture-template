import '../repositories/theme_repository.dart';
import '../entities/theme_entity.dart';

class GetThemeUseCase {
  final ThemeRepository repository;

  GetThemeUseCase(this.repository);

  Future<ThemeEntity> call() async {
    return await repository.getTheme();
  }
}
