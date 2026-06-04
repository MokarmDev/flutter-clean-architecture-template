import '../../../../core/storage/shared_prefs_service.dart';
import '../../../../core/storage/storage_keys.dart';
import '../../domain/entities/theme_entity.dart';

class ThemeLocalDataSource {
  final SharedPreferencesService sharedPreferencesService;
  ThemeLocalDataSource(this.sharedPreferencesService);

  Future saveTheme(ThemeType themeType) async {
    sharedPreferencesService.saveString(
      StorageKeys.themeKey,
      themeType == ThemeType.dark ? 'dark' : 'light',
    );
  }

  Future getTheme() async {
    final theme = sharedPreferencesService.getString(StorageKeys.themeKey);
    return theme == 'dark'
        ? ThemeEntity(type: ThemeType.dark)
        : ThemeEntity(type: ThemeType.light);
  }
}
