import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:movies/src/pages/home_page.dart';
import 'package:movies/src/pages/search_page.dart';

class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> with WidgetsBindingObserver {
  String tabTitle = 'En cines';
  Color mainColor = Color.fromRGBO(24, 33, 46, 1.0);

  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();

  Widget _homeTab;
  Widget getHomeTab() {
    if (_homeTab == null) {
      _homeTab = Container(
          child: Stack(
        children: <Widget>[getBackground(context), HomePage()],
      ));
    }
    return _homeTab;
  }

  Widget _searchTab;
  Widget getSearchTab() {
    if (_searchTab == null) {
      _searchTab = Container(
          child: Stack(
        children: <Widget>[getBackground(context), SearchPage()],
      ));
    }
    return _searchTab;
  }

  Widget _newsTab;
  Widget getNewsTab() {
    if (_newsTab == null) {
      _newsTab = Container(
          child: Center(
        child: Text('Buscar'),
      ));
    }
    return _newsTab;
  }

  Widget _configTab;
  Widget getConfigTab() {
    if (_configTab == null) {
      _configTab = Container(
          child: Center(
        child: Text('Buscar'),
      ));
    }
    return _configTab;
  }

  Widget getComingsoon() {
    tabTitle = 'Próximamente';
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
            mainColor,
            Color.fromRGBO(24, 33, 46, 1.0),
            Color.fromRGBO(37, 51, 72, 1.0),
            Color.fromRGBO(57, 79, 111, 1.0),
          ])),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _children = [
      getHomeTab(),
      getSearchTab(),
      getNewsTab(),
      getConfigTab()
    ];

    Widget textTitle = Text(
      tabTitle,
      style: TextStyle(fontFamily: 'RussoOne', fontWeight: FontWeight.normal),
    );

    return Scaffold(
      appBar: AppBar(
        title: textTitle,
        centerTitle: true,
        elevation: 0,
        backgroundColor: mainColor,
      ),
      //body: _children[_page],
      body: IndexedStack(
        children: _children,
        index: _page,
      ),
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 0,
        height: 50.0,
        items: <Widget>[
          Icon(Icons.home, size: 25, color: Colors.orangeAccent),
          Icon(Icons.search, size: 25, color: Colors.orangeAccent),
          Icon(Icons.fiber_new, size: 25, color: Colors.orangeAccent),
          Icon(Icons.settings, size: 25, color: Colors.orangeAccent),
        ],
        color: mainColor,
        buttonBackgroundColor: mainColor,
        backgroundColor: Color.fromRGBO(57, 79, 111, 1.0),
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 350),
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
      ),
      drawer: DrawerHeader(child: Container()),
    );
  }
}
