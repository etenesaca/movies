import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movies/common/extras.dart';

class SettingsPage extends StatelessWidget {
  Extras extras = Extras();
  Color colorActions;
  Color colorItems;
  TextStyle textStyleItems;

  @override
  Widget build(BuildContext context) {
    colorActions = Colors.teal;
    colorItems = Colors.white70;
    textStyleItems = TextStyle(
        color: Colors.white, fontWeight: FontWeight.w700, fontSize: 14);
    Widget menu = Container(
      child: SafeArea(
          child: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            userSection(),
            SizedBox(height: 15),
            extras.buildSection(
                title: '', child: menuOptions(), textBackground: 'Opciones'),
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
      children: <Widget>[menu, buildBackgroundLogout(), buildButtonLogout()],
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
        title: Text('Juan Perez', style: textStyleItems),
        trailing: Icon(Icons.edit, color: Colors.white),
      ),
    );
  }

  menuOptions() {
    return Card(
      color: Color.fromRGBO(30, 144, 255, 0.25),
      elevation: 4.0,
      margin: const EdgeInsets.fromLTRB(32, 8, 32, 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: <Widget>[
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
            leading: Icon(Icons.language, color: colorActions),
            title: Text('Cambiar idioma', style: textStyleItems),
            trailing: Icon(Icons.keyboard_arrow_right, color: colorItems),
          )
        ],
      ),
    );
  }

  menuMovies() {
    return Card(
      color: Color.fromRGBO(30, 144, 255, 0.25),
      elevation: 4.0,
      margin: const EdgeInsets.fromLTRB(32, 8, 32, 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: <Widget>[
          ListTile(
            onTap: () {},
            leading: Icon(Icons.list, color: colorActions),
            title: Text(
              'Mi lista',
              style: textStyleItems,
            ),
            trailing: Icon(Icons.keyboard_arrow_right, color: colorItems),
          ),
        ],
      ),
    );
  }

  _buildDivider() {
    return Container(
      height: 1.0,
      margin: EdgeInsets.symmetric(horizontal: 8),
      color: Colors.grey.shade600,
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
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.orangeAccent),
          ),
        ),
        SwitchListTile(
            contentPadding: EdgeInsets.all(0),
            activeColor: colorActions,
            value: true,
            title: Text('Recibir notificaciones', style: textStyleItems),
            onChanged: (bool value) {}),
        SwitchListTile(
            contentPadding: EdgeInsets.all(0),
            activeColor: colorActions,
            inactiveThumbColor: Colors.grey.shade800,
            value: false,
            title: Text('Nuevas peliculas', style: textStyleItems),
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
}
