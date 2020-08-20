import 'dart:io' show Platform;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:movies/common/extras.dart';
import 'package:movies/generated/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSettings {
  String _langAppKey = 'langApp';
  String _langMoviesKey = 'langMovies';
  String _useDeviceLanguageKey = 'useDeviceLanguage';

  String getLocaleStrName(BuildContext context, String localeStr) {
    return Extras().getLocaleName(context, string2Locale(localeStr));
  }

  String getLocaleName(BuildContext context, Locale locale) {
    return Extras().getLocaleName(context, locale);
  }

  String locale2String(Locale locale) {
    String scriptCode =
        (locale.scriptCode == null) ? '' : '-${locale.scriptCode}';
    String countryCode =
        (locale.countryCode == null) ? '' : '-${locale.countryCode}';
    return '${locale.languageCode}$scriptCode$countryCode';
  }

  Locale string2Locale(String localeStr, [String separator = '-']) {
    List<String> localeParts = localeStr.split(separator);
    String scriptCode;
    String countryCode;
    switch (localeParts.length) {
      case 1:
        scriptCode = null;
        countryCode = null;
        break;
      case 2:
        scriptCode = null;
        countryCode = localeParts[1];
        break;
      case 3:
        scriptCode = localeParts[1];
        countryCode = localeParts[2];
        break;
      default:
    }
    return Locale.fromSubtags(
        languageCode: localeParts[0],
        scriptCode: scriptCode,
        countryCode: countryCode);
  }

  List<Locale> getLanguagesAvailable() {
    List<Locale> supportedLangueages = S.delegate.supportedLocales;
    return supportedLangueages;
  }

  List<String> getLanguagesAvailableStr() =>
      getLanguagesAvailable().map((l) => locale2String(l));

  Locale getSystemLanguage() => string2Locale(Platform.localeName, '_');

  Locale getLanguageDefaultApp() {
    Locale sysLang = getSystemLanguage();
    List<Locale> languagesAvailable = getLanguagesAvailable();
    List<String> strLanguageAvailable =
        languagesAvailable.map((l) => locale2String(l)).toList();
    return (strLanguageAvailable.contains(locale2String(sysLang)))
        ? sysLang
        : languagesAvailable[0];
  }

  String getLanguageDefaultAppStr() => locale2String(getLanguageDefaultApp());
  String getLanguageDefaultMoviesStr() => locale2String(getSystemLanguage());

  Future<Locale> getLocaleApp() async {
    final prefs = await SharedPreferences.getInstance();
    String res = prefs.getString(_langAppKey) ?? '';
    bool useDeviceLanguage = await getUseDeviceLanguage();
    Locale resLocal = (useDeviceLanguage || res.isEmpty)
        ? getLanguageDefaultApp()
        : string2Locale(res);
    return resLocal;
  }

  Future<String> getLangApp() async {
    Locale locale = await getLocaleApp();
    return locale2String(locale);
  }

  Future<String> getLangMovies() async {
    final prefs = await SharedPreferences.getInstance();
    String res = prefs.getString(_langMoviesKey) ?? '';
    bool useDeviceLanguage = await getUseDeviceLanguage();
    if (useDeviceLanguage || res.isEmpty) {
      res = getLanguageDefaultMoviesStr();
    }
    return res;
  }

  Future<bool> getUseDeviceLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    bool res = prefs.getBool(_useDeviceLanguageKey) ?? true;
    return res;
  }

  Future<void> setLangApp(String langApp) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_langAppKey, langApp);
  }

  Future<void> setLangMovies(String langMovies) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_langMoviesKey, langMovies);
  }

  Future<void> setUseDeviceLanguage(bool useDeviceLanguage) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_useDeviceLanguageKey, useDeviceLanguage);
  }

  List<String> allLocales = [
    'af-ZA',
    'am-ET',
    'ar-AE',
    'ar-BH',
    'ar-DZ',
    'ar-EG',
    'ar-IQ',
    'ar-JO',
    'ar-KW',
    'ar-LB',
    'ar-LY',
    'ar-MA',
    'arn-CL',
    'ar-OM',
    'ar-QA',
    'ar-SA',
    'ar-SY',
    'ar-TN',
    'ar-YE',
    'as-IN',
    'az-Cyrl-AZ',
    'az-Latn-AZ',
    'ba-RU',
    'be-BY',
    'bg-BG',
    'bn-BD',
    'bn-IN',
    'bo-CN',
    'br-FR',
    'bs-Cyrl-BA',
    'bs-Latn-BA',
    'ca-ES',
    'co-FR',
    'cs-CZ',
    'cy-GB',
    'da-DK',
    'de-AT',
    'de-CH',
    'de-DE',
    'de-LI',
    'de-LU',
    'dsb-DE',
    'dv-MV',
    'el-GR',
    'en-029',
    'en-AU',
    'en-BZ',
    'en-CA',
    'en-GB',
    'en-IE',
    'en-IN',
    'en-JM',
    'en-MY',
    'en-NZ',
    'en-PH',
    'en-SG',
    'en-TT',
    'en-US',
    'en-ZA',
    'en-ZW',
    'es-AR',
    'es-BO',
    'es-CL',
    'es-CO',
    'es-CR',
    'es-DO',
    'es-EC',
    'es-ES',
    'es-GT',
    'es-HN',
    'es-MX',
    'es-NI',
    'es-PA',
    'es-PE',
    'es-PR',
    'es-PY',
    'es-SV',
    'es-US',
    'es-UY',
    'es-VE',
    'et-EE',
    'eu-ES',
    'fa-IR',
    'fi-FI',
    'fil-PH',
    'fo-FO',
    'fr-BE',
    'fr-CA',
    'fr-CH',
    'fr-FR',
    'fr-LU',
    'fr-MC',
    'fy-NL',
    'ga-IE',
    'gd-GB',
    'gl-ES',
    'gsw-FR',
    'gu-IN',
    'ha-Latn-NG',
    'he-IL',
    'hi-IN',
    'hr-BA',
    'hr-HR',
    'hsb-DE',
    'hu-HU',
    'hy-AM',
    'id-ID',
    'ig-NG',
    'ii-CN',
    'is-IS',
    'it-CH',
    'it-IT',
    'iu-Cans-CA',
    'iu-Latn-CA',
    'ja-JP',
    'ka-GE',
    'kk-KZ',
    'kl-GL',
    'km-KH',
    'kn-IN',
    'kok-IN',
    'ko-KR',
    'ky-KG',
    'lb-LU',
    'lo-LA',
    'lt-LT',
    'lv-LV',
    'mi-NZ',
    'mk-MK',
    'ml-IN',
    'mn-MN',
    'mn-Mong-CN',
    'moh-CA',
    'mr-IN',
    'ms-BN',
    'ms-MY',
    'mt-MT',
    'nb-NO',
    'ne-NP',
    'nl-BE',
    'nl-NL',
    'nn-NO',
    'nso-ZA',
    'oc-FR',
    'or-IN',
    'pa-IN',
    'pl-PL',
    'prs-AF',
    'ps-AF',
    'pt-BR',
    'pt-PT',
    'qut-GT',
    'quz-BO',
    'quz-EC',
    'quz-PE',
    'rm-CH',
    'ro-RO',
    'ru-RU',
    'rw-RW',
    'sah-RU',
    'sa-IN',
    'se-FI',
    'se-NO',
    'se-SE',
    'si-LK',
    'sk-SK',
    'sl-SI',
    'sma-NO',
    'sma-SE',
    'smj-NO',
    'smj-SE',
    'smn-FI',
    'sms-FI',
    'sq-AL',
    'sr-Cyrl-BA',
    'sr-Cyrl-CS',
    'sr-Cyrl-ME',
    'sr-Cyrl-RS',
    'sr-Latn-BA',
    'sr-Latn-CS',
    'sr-Latn-ME',
    'sr-Latn-RS',
    'sv-FI',
    'sv-SE',
    'sw-KE',
    'syr-SY',
    'ta-IN',
    'te-IN',
    'tg-Cyrl-TJ',
    'th-TH',
    'tk-TM',
    'tn-ZA',
    'tr-TR',
    'tt-RU',
    'tzm-Latn-DZ',
    'ug-CN',
    'uk-UA',
    'ur-PK',
    'uz-Cyrl-UZ',
    'uz-Latn-UZ',
    'vi-VN',
    'wo-SN',
    'xh-ZA',
    'yo-NG',
    'zh-CN',
    'zh-HK',
    'zh-MO',
    'zh-SG',
    'zh-TW',
    'zu-ZA'
  ];
}
