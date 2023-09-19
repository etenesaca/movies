import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movies/common/extras.dart';
import 'package:movies/generated/l10n.dart';
import 'package:movies/src/pages/home_page.dart';
import 'package:movies/src/pages/new_page.dart';
import 'package:movies/src/pages/popular_actors.dart';
import 'package:movies/src/pages/search_page.dart';
import 'package:movies/src/pages/settings_page.dart';
import 'package:movies/src/providers/global_provider.dart';
import 'package:movies/src/apis/the_movie_db_api.dart';
import 'package:provider/provider.dart';

class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> with WidgetsBindingObserver {
  Extras extras = Extras();
  Color mainColor = Color.fromRGBO(24, 33, 46, 1.0);
  final moviesProvider = MovieProvider();

  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();

  Widget? _homeTab;
  Widget getHomeTab(BuildContext context) {
    if (_homeTab == null) {
      _homeTab = Container(
          child: Stack(
        children: <Widget>[extras.getBackgroundApp(), HomePage()],
      ));
    }
    return _homeTab!;
  }

  Widget? _searchTab;
  Widget getSearchTab(BuildContext context) {
    if (_searchTab == null) {
      _searchTab = Container(
          child: Stack(
        children: <Widget>[extras.getBackgroundApp(), SearchPage()],
      ));
    }
    return _searchTab!;
  }

  Widget? _newsTab;
  Widget getNewsTab() {
    if (_newsTab == null) {
      _newsTab = Container(
          child: Stack(
        children: <Widget>[extras.getBackgroundApp(), NewPage()],
      ));
    }
    return _newsTab!;
  }

  Widget? _actorsTab;
  Widget getActorsTab() {
    if (_actorsTab == null) {
      _actorsTab = Container(
          child: Stack(
        children: <Widget>[extras.getBackgroundApp(), PopularActorsPage()],
      ));
    }
    return _actorsTab!;
  }

  Widget? _configTab;
  Widget getConfigTab() {
    if (_configTab == null) {
      _configTab = Container(
          child: Stack(
        children: <Widget>[extras.getBackgroundApp(), SettingsPage()],
      ));
    }
    return _configTab!;
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<GlobalProvider>(context, listen: false).loadMovieGenders());
  }

  @override
  Widget build(BuildContext context) {
    /*
    if (context.watch<GlobalProvider>().allMovieGenres.length == 0) {
      Provider.of<GlobalProvider>(context).loadMovieGenders();
    }
     */
    final List<Widget> _children = [
      getHomeTab(context),
      getSearchTab(context),
      getNewsTab(),
      getActorsTab(),
      getConfigTab()
    ];

    String tabTitle = S.of(context)!.nowPlaying;
    Widget textTitle = Text(
      tabTitle,
      style: TextStyle(fontFamily: 'RussoOne', fontWeight: FontWeight.normal),
    );

    return Scaffold(
      /*
      appBar: AppBar(
        title: textTitle,
        centerTitle: true,
        elevation: 0,
        backgroundColor: mainColor,
      ),
       */
      //body: _children[_page]
      backgroundColor: extras.mainColor,
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
          Icon(Icons.people, size: 25, color: Colors.orangeAccent),
          Icon(Icons.menu, size: 25, color: Colors.orangeAccent),
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
