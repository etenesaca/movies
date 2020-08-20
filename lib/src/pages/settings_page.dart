import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movies/blocs/preferences_bloc.dart';
import 'package:movies/common/app_settings.dart';
import 'package:movies/common/extras.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key key}) : super(key: key);
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String _langApp;
  String _langMovies;
  bool _defLanguages;

  Extras extras = Extras();
  Color colorActions;
  Color colorItems;
  TextStyle colorTextSwitch;
  TextStyle textStyleItems;
  TextStyle textStyleLanguage;
  TextStyle textStyleUser;

  @override
  void initState() {
    super.initState();
    fToast = FToast(context);
    loadSettings();
  }

  @override
  Widget build(BuildContext context) {
    colorActions = Colors.teal;
    colorItems = Colors.white70;
    colorTextSwitch = TextStyle(color: Colors.white70, fontSize: 14);
    textStyleItems = TextStyle(
        color: Colors.white, fontWeight: FontWeight.w700, fontSize: 14);
    textStyleLanguage = TextStyle(
        color: Colors.white60, fontWeight: FontWeight.w600, fontSize: 11);
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
    final resPage = Stack(
      fit: StackFit.expand,
      children: <Widget>[
        menu,
        //buildBackgroundLogout(), buildButtonLogout()
      ],
    );
    return resPage;
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

  String getCurrentLang(BuildContext context) {
    final cLang = context.bloc<PreferencesBloc>().state.locale;
    return AppSettings().getLocaleName(context, cLang);
  }

  menuOptions(BuildContext context) {
    return buildMenu(children: [
      ListTile(
        onTap: () => tapSelectLanguage(context),
        leading: Icon(Icons.language, color: colorActions),
        title: Text('Cambiar idioma', style: textStyleItems),
        subtitle: Text(
          getCurrentLang(context),
          style: textStyleLanguage,
        ),
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

  buildMenu({@required List<Widget> children}) {
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
    final Locale locale = AppSettings().string2Locale(countryCode);
    return Row(
      children: <Widget>[
        Image.asset('assets/country_flags/${locale.languageCode}.png',
            width: 25),
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
    final appSettings = AppSettings();
    appSettings.getLanguagesAvailable().forEach((l) {
      appLanguages.add(buildMenuItemLanguage(
          appSettings.locale2String(l), appSettings.getLocaleName(context, l)));
    });

    List<DropdownMenuItem<String>> appLocales =
        appSettings.allLocales.map((e) => buildItemLocale(e)).toList();

    final textStyle = TextStyle(fontSize: 14, fontWeight: FontWeight.bold);
    final btnTextStyle = TextStyle(fontWeight: FontWeight.bold);
    final preferencesBloc = context.bloc<PreferencesBloc>();
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
                      value: _defLanguages,
                      title: Text('Idioma del dispositivo',
                          style: TextStyle(fontSize: 14)),
                      onChanged: (bool value) {
                        _defLanguages = value;
                        if (value) {
                          _langApp = appSettings.getLanguageDefaultAppStr();
                          _langMovies =
                              appSettings.getLanguageDefaultMoviesStr();
                        }
                        setState(() {});
                      }),
                  Text('Aplicación', style: textStyle),
                  !_defLanguages
                      ? DropdownButton(
                          isExpanded: true,
                          value: _langApp,
                          items: appLanguages,
                          onChanged: (String val) {
                            _langApp = val;
                            setState(() {});
                          })
                      : Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: buildItemAppLang(_langApp,
                              appSettings.getLocaleStrName(context, _langApp))),
                  Text('Peliculas', style: textStyle),
                  !_defLanguages
                      ? DropdownButton(
                          isExpanded: true,
                          value: _langMovies,
                          items: appLocales,
                          onChanged: (String val) {
                            _langMovies = val;
                            setState(() {});
                          })
                      : Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: buildItemMovieLang(_langMovies)),
                ],
              ),
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cancelar', style: btnTextStyle)),
                FlatButton(
                    onPressed: () {
                      preferencesBloc.add(
                          ChangeLocale(appSettings.string2Locale(_langApp)));
                      print('Idioma cambiado');
                      print(preferencesBloc.state.locale.toString());
                      print('-------------------');
                      setLangMovies(_langMovies);
                      showToast('Guardado');
                      setUseDeviceLanguage(_defLanguages);
                      Navigator.pop(context);
                      //Phoenix.rebirth(context);
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

  FToast fToast;
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
    _defLanguages = await settings.getUseDeviceLanguage();
    setState(() {});
  }

  void setLangMovies(String langMovies) async {
    await AppSettings().setLangMovies(langMovies);
    setState(() {});
  }

  void setUseDeviceLanguage(bool useDeviceLanguage) async {
    await AppSettings().setUseDeviceLanguage(useDeviceLanguage);
    setState(() {});
  }
}
