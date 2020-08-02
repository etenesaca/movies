import 'dart:io' show Platform;

import 'package:shared_preferences/shared_preferences.dart';

class AppSettings {
  List<String> appLanguages = ['es', 'en'];

  getLangApp() async {
    final prefs = await SharedPreferences.getInstance();
    String sysLang = Platform.localeName.split('_')[0];

    String res = prefs.getString('langApp') ?? '';
    if (res.isEmpty) {
      res = appLanguages.contains(sysLang) ? sysLang : 'en';
    }
    return res;
  }

  getLangMovies() async {
    final prefs = await SharedPreferences.getInstance();
    String sysLang = Platform.localeName.split('_')[0];
    String sysCountry = Platform.localeName.split('_')[1];

    String res = prefs.getString('langMovies') ?? '';
    if (res.isEmpty) {
      res = '$sysLang-$sysCountry';
    }
    return res;
  }
}
