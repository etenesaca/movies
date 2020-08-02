import 'dart:io' show Platform;

import 'package:shared_preferences/shared_preferences.dart';

class AppSettings {
  List<String> appLanguages = ['es', 'en'];

  String getDefaultLangApp() {
    String sysLang = Platform.localeName.split('_')[0];
    return appLanguages.contains(sysLang) ? sysLang : 'en';
  }

  getLangApp() async {
    final prefs = await SharedPreferences.getInstance();
    String res = prefs.getString('langApp') ?? '';
    bool defLanguages = await getUseDevideLanguage();
    if (defLanguages || res.isEmpty) {
      res = getDefaultLangApp();
    }
    return res;
  }

  String getDefaultLangMovies() {
    String sysLang = Platform.localeName.split('_')[0];
    String sysCountry = Platform.localeName.split('_')[1];
    return '$sysLang-$sysCountry';
  }

  getLangMovies() async {
    final prefs = await SharedPreferences.getInstance();
    String res = prefs.getString('langMovies') ?? '';
    bool defLanguages = await getUseDevideLanguage();
    if (defLanguages || res.isEmpty) {
      res = getDefaultLangMovies();
    }
    return res;
  }

  getUseDevideLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    bool res = prefs.getBool('useDevideLanguage') ?? true;
    return res;
  }
}
