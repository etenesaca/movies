import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movies/common/app_settings.dart';
import 'package:movies/common/extras.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key? key}) : super(key: key);
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  List<String> localeList = [
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
  Map<String, String> appLanguagesMap = {
    'es': 'Español',
    'en': 'English',
  };

  String? _langApp;
  String? _langMovies;
  bool? _defLanguages;

  Extras? extras = Extras();
  Color? colorActions;
  Color? colorItems;
  TextStyle? colorTextSwitch;
  TextStyle? textStyleItems;
  TextStyle? textStyleUser;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    loadSettings();
  }

  @override
  Widget build(BuildContext context) {
    colorActions = Colors.teal;
    colorItems = Colors.white70;
    colorTextSwitch = TextStyle(color: Colors.white70, fontSize: 14);
    textStyleItems = TextStyle(
        color: Colors.white, fontWeight: FontWeight.w700, fontSize: 14);
    textStyleUser = TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w700,
        fontSize: 16,
        fontFamily: 'Cinzel');

    Widget menu = Container(
      child: SafeArea(
          child: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            userSection(),
            extras.buildSection(
                title: '',
                child: menuOptions(context),
                textBackground: 'Opciones'),
            menuMovies(),
            SizedBox(height: 30),
            _notifications(),
            SizedBox(height: 60),
          ],
        ),
      )),
    );
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        menu,
        //buildBackgroundLogout(), buildButtonLogout()
      ],
    );
  }

  userSection() {
    return Card(
      elevation: 8.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: colorActions,
      margin: EdgeInsets.all(8.0),
      child: ListTile(
        onTap: () {},
        leading: extras.buildAvatar(
            Colors.grey,
            'Juan Perez',
            NetworkImage(
                'https://pymstatic.com/41016/conversions/como-ayudar-a-persona-celosa-thumb.jpg'),
            22),
        title: Text('Juan Perez', style: textStyleUser),
        trailing: Icon(Icons.edit, color: Colors.white),
      ),
    );
  }

  menuOptions(BuildContext context) {
    return buildMenu(children: [
      ListTile(
        onTap: () => tapSelectLanguage(context),
        leading: Icon(Icons.language, color: colorActions),
        title: Text('Cambiar idioma', style: textStyleItems),
        trailing: Icon(Icons.keyboard_arrow_right, color: colorItems),
      ),
      _buildDivider(),
      ListTile(
        onTap: () {},
        leading: Icon(Icons.lock_outline, color: colorActions),
        title: Text(
          'Cambiar contraseña',
          style: textStyleItems,
        ),
        trailing: Icon(Icons.keyboard_arrow_right, color: colorItems),
      ),
      _buildDivider(),
      ListTile(
        onTap: () {},
        leading: Icon(Icons.info_outline, color: colorActions),
        title: Text('Acerca de', style: textStyleItems),
        //trailing: Icon(Icons.keyboard_arrow_right, color: colorItems),
      ),
      _buildDivider(),
      ListTile(
        onTap: () {},
        leading: Icon(Icons.power_settings_new, color: colorActions),
        title: Text('Cerrar sesión', style: textStyleItems),
        //trailing: Icon(Icons.keyboard_arrow_right, color: colorItems),
      ),
    ]);
  }

  buildMenu({required List<Widget> children}) {
    return Card(
      color: Color.fromRGBO(30, 144, 255, 0.25),
      elevation: 4.0,
      margin: const EdgeInsets.fromLTRB(25, 8, 25, 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: children,
      ),
    );
  }

  menuMovies() {
    return buildMenu(children: [
      ListTile(
        onTap: () {},
        leading: Icon(Icons.list, color: colorActions),
        title: Text(
          'Mi lista',
          style: textStyleItems,
        ),
        trailing: Icon(Icons.keyboard_arrow_right, color: colorItems),
      ),
    ]);
  }

  _buildDivider() {
    return Container(
      height: 1.0,
      margin: EdgeInsets.symmetric(horizontal: 8),
      color: Colors.grey.shade700,
      width: double.infinity,
    );
  }

  _notifications() {
    return Column(
      children: <Widget>[
        Align(
          alignment: Alignment.bottomLeft,
          child: Text(
            'Notificaciones',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.orangeAccent),
          ),
        ),
        SwitchListTile(
            contentPadding: EdgeInsets.all(0),
            activeColor: colorActions,
            value: true,
            title: Text('Recibir notificaciones', style: colorTextSwitch),
            onChanged: (bool value) {}),
        SwitchListTile(
            contentPadding: EdgeInsets.all(0),
            activeColor: colorActions,
            inactiveThumbColor: Colors.grey.shade800,
            value: false,
            title: Text('Nuevas peliculas', style: colorTextSwitch),
            onChanged: (bool value) {})
      ],
    );
  }

  buildBackgroundLogout() {
    return Positioned(
        bottom: -20,
        left: -20,
        child: Container(
          height: 80,
          width: 80,
          alignment: Alignment.center,
          decoration:
              BoxDecoration(color: colorActions, shape: BoxShape.circle),
        ));
  }

  buildButtonLogout() {
    return Positioned(
      bottom: 0,
      left: 0,
      child: IconButton(
          icon: Icon(FontAwesomeIcons.powerOff, color: Colors.white70),
          onPressed: () {}),
    );
  }

  Widget buildItemAppLang(String countryCode, String title) {
    final textStyle = TextStyle(fontSize: 13);
    return Row(
      children: <Widget>[
        Image.asset('assets/country_flags/$countryCode.png', width: 25),
        SizedBox(width: 5),
        Text(title, style: textStyle)
      ],
    );
  }

  DropdownMenuItem<String> buildMenuItemLanguage(
      String countryCode, String title) {
    return DropdownMenuItem<String>(
        value: countryCode, child: buildItemAppLang(countryCode, title));
  }

  Widget buildItemMovieLang(String locale) {
    final textStyle = TextStyle(fontSize: 13);
    return Row(
      children: <Widget>[
        Icon(Icons.language, color: Colors.grey, size: 25),
        SizedBox(width: 5),
        Text(locale, style: textStyle)
      ],
    );
  }

  DropdownMenuItem<String> buildItemLocale(String locale) {
    return DropdownMenuItem<String>(
        value: locale, child: buildItemMovieLang(locale));
  }

  tapSelectLanguage(BuildContext context) {
    List<DropdownMenuItem<String>> appLanguages = [];
    appLanguagesMap.forEach((k, v) {
      appLanguages.add(buildMenuItemLanguage(k, v));
    });

    List<DropdownMenuItem<String>> appLocales =
        localeList.map((e) => buildItemLocale(e)).toList();

    final textStyle = TextStyle(fontSize: 14, fontWeight: FontWeight.bold);
    final btnTextStyle = TextStyle(fontWeight: FontWeight.bold);
    showDialog(
      context: context,
      //barrierDismissible: false,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              elevation: 15,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              title: Text('Idiomas'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SwitchListTile(
                      contentPadding: EdgeInsets.all(0),
                      activeColor: colorActions,
                      value: _defLanguages!,
                      title: Text('Idioma del dispositivo',
                          style: TextStyle(fontSize: 14)),
                      onChanged: (bool value) {
                        _defLanguages = value;
                        if (value) {
                          _langApp = AppSettings().getDefaultLangApp();
                          _langMovies = AppSettings().getDefaultLangMovies();
                        }
                        setState(() {});
                      }),
                  Text('Aplicación', style: textStyle),
                  !_defLanguages!
                      ? DropdownButton(
                          isExpanded: true,
                          value: _langApp,
                          items: appLanguages,
                          onChanged: (String? val) {
                            _langApp = val;
                            setState(() {});
                          })
                      : Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: buildItemAppLang(
                              _langApp ?? '', appLanguagesMap[_langApp] ?? '')),
                  Text('Peliculas', style: textStyle),
                  !_defLanguages!
                      ? DropdownButton(
                          isExpanded: true,
                          value: _langMovies,
                          items: appLocales,
                          onChanged: (String? val) {
                            _langMovies = val;
                            setState(() {});
                          })
                      : Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: buildItemMovieLang(_langMovies!)),
                ],
              ),
              actions: <Widget>[
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cancelar', style: btnTextStyle)),
                ElevatedButton(
                    onPressed: () {
                      setLangApp(_langApp!);
                      setLangMovies(_langMovies!);
                      showToast('Guardado');
                      setUseDevideLanguage(_defLanguages!);
                      Navigator.pop(context);
                      Phoenix.rebirth(context);
                    },
                    child: Text(
                      'Guardar',
                      style: btnTextStyle,
                    ))
              ],
            );
          },
        );
      },
    );
  }

  FToast? fToast;
  showToast(String text) {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.greenAccent,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check),
          SizedBox(
            width: 12.0,
          ),
          Text(text),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 2),
    );
  }

  loadSettings() async {
    final settings = AppSettings();
    _langMovies = await settings.getLangMovies();
    _langApp = await settings.getLangApp();
    _defLanguages = await settings.getUseDevideLanguage();
    setState(() {});
  }

  void setLangApp(String langApp) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('langApp', langApp);
  }

  void setLangMovies(String langMovies) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('langMovies', langMovies);
    setState(() {});
  }

  void setUseDevideLanguage(bool useDevideLanguage) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('useDevideLanguage', useDevideLanguage);
  }
}
