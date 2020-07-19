import 'package:flutter/material.dart';
import 'package:movies/src/pages/home_page.dart';
import 'package:movies/src/pages/movie_detail_page.dart';
import 'package:movies/src/pages/root.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Peliculas',
      routes: {
        '/': (BuildContext context) => RootPage(),
        'home': (BuildContext context) => HomePage(),
        'movie_detail': (BuildContext context) => MovieDetailPage()
      },
      theme: ThemeData(fontFamily: 'Quicksand'),
      initialRoute: '/',
    );
  }
}
