import '../../domain/repositories/theme_repository.dart';
import '../../domain/entities/theme_entity.dart';
import '../datasources/theme_local_data_source.dart';

class ThemeRepositoryImpl implements ThemeRepository {
  final ThemeLocalDataSource localDataSource;

  ThemeRepositoryImpl(this.localDataSource);

  @override
  Future<ThemeEntity> getTheme() async {
    return await localDataSource.getTheme();
  }

  @override
  Future saveTheme(ThemeEntity theme) async {
    await localDataSource.saveTheme(theme.type);
  }
}
