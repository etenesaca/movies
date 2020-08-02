import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movies/common/extras.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key key}) : super(key: key);
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Extras extras = Extras();
  Color colorActions;
  Color colorItems;
  TextStyle colorTextSwitch;
  TextStyle textStyleItems;
  TextStyle textStyleUser;

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

  buildItemLanguage(String title, String countryCode) {
    final textStyle = TextStyle(fontSize: 14);
    return DropdownMenuItem(
        value: countryCode,
        child: Row(
          children: <Widget>[
            Image.asset('assets/country_flags/$countryCode.png', width: 25),
            SizedBox(width: 5),
            Text(title, style: textStyle)
          ],
        ));
  }

  String _langApp;
  String _langMovies;

  tapSelectLanguage(BuildContext context) {
    List<DropdownMenuItem<String>> appLanguages = [
      buildItemLanguage('Español', 'es'),
      buildItemLanguage('English', 'en'),
    ];
    final textStyle = TextStyle(fontSize: 14, fontWeight: FontWeight.bold);
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, setState) {
            return AlertDialog(
              title: Text('Idiomas'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Aplicación', style: textStyle),
                  DropdownButton(
                      value: _langApp,
                      items: appLanguages,
                      onChanged: (String val) {
                        _langApp = val;
                        setState(() {});
                      }),
                  Text('Peliculas', style: textStyle),
                  DropdownButton(
                      value: _langMovies,
                      items: appLanguages,
                      onChanged: (String val) {
                        _langMovies = val;
                        setState(() {});
                      }),
                ],
              ),
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cancelar')),
                FlatButton(onPressed: () {}, child: Text('Guardar'))
              ],
            );
          },
        );
      },
    );
  }
}
