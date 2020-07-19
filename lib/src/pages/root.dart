import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:movies/src/pages/home_page.dart';

class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  String tapTitle = 'En cines';
  Color mainColor = Color.fromRGBO(24, 33, 46, 1.0);

  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();

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
            mainColor,
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

    final List<Widget> _children = [homeTap, getSearch(), getComingsoon()];

    Widget textTitle = Text(
      tapTitle,
      style: TextStyle(fontFamily: 'RussoOne', fontWeight: FontWeight.normal),
    );

    Color colorNavBar = Colors.blueGrey;

    return Scaffold(
      appBar: AppBar(
        title: textTitle,
        centerTitle: true,
        elevation: 0,
        backgroundColor: mainColor,
      ),
      body: _children[_page],
      /**
       * 
      body: Container(
        color: Colors.blueAccent,
        child: Center(
          child: Column(
            children: <Widget>[
              Text(_page.toString(), textScaleFactor: 10.0),
              RaisedButton(
                child: Text('Go To Page of index 1'),
                onPressed: () {
                  final CurvedNavigationBarState navBarState =
                      _bottomNavigationKey.currentState;
                  navBarState.setPage(1);
                },
              )
            ],
          ),
        ),
      ),
       */
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
        animationDuration: Duration(milliseconds: 400),
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
      ),
    );
  }
}
