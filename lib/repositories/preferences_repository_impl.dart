import 'dart:io' show Platform;
import 'dart:ui';
import 'package:movies/common/app_settings.dart';
import 'preferences_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesRepositoryImpl implements PreferencesRepository {
  @override
  Future<void> saveLocale(Locale locale) async {
    await AppSettings().setLangApp(AppSettings().locale2String(locale));
  }

  @override
  Future<Locale> get locale async {
    Locale locale = await AppSettings().getLocaleApp();
    return locale;
  }
}
