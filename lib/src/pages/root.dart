import 'package:flutter/material.dart';
import 'package:movies/src/pages/home_page.dart';

class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  String tapTitle;
  int _currentIndex = 0;

  Widget getSearch() {
    tapTitle = 'Buscar';
    final res = Container(
        child: Center(
      child: Text('Buscar'),
    ));
    return res;
  }

  Widget getComingsoon() {
    tapTitle = 'Próximamente';
    final res = Container(
        child: Center(
      child: Text('Proximanemente'),
    ));
    return res;
  }

  getBackground(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: FractionalOffset(.0, 0.5),
              end: FractionalOffset(0.0, 1.0),
              colors: [
            Color.fromRGBO(24, 33, 46, 1.0),
            Color.fromRGBO(24, 33, 46, 1.0),
            Color.fromRGBO(37, 51, 72, 1.0),
            Color.fromRGBO(57, 79, 111, 1.0),
          ])),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget homeTap = Container(
        child: Stack(
      children: <Widget>[getBackground(context), HomePage()],
    ));

    final List<Widget> _children = [
      homeTap,
      getSearch(),
      getComingsoon()
    ];

    void onTabTapped(int index) {
      _currentIndex = index;
      setState(() {});
    }

    Widget textTitle = Text(
      tapTitle,
      style: TextStyle(fontFamily: 'RussoOne', fontWeight: FontWeight.normal),
    );

    return Scaffold(
      appBar: AppBar(
        title: textTitle,
        centerTitle: true,
        elevation: 0,
        backgroundColor: Color.fromRGBO(24, 33, 46, 1.0),
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped, // new
        currentIndex: _currentIndex, // new
        items: [
          new BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.mail),
            title: Text('Messages'),
          ),
          new BottomNavigationBarItem(
              icon: Icon(Icons.person), title: Text('Profile'))
        ],
      ),
    );
  }
}
