import 'package:flutter/material.dart';
import 'package:movies/src/pages/actor_page.dart';
import 'package:movies/src/providers/global_provider.dart';
import 'package:movies/src/providers/search_provider.dart';
import 'package:movies/src/pages/home_page.dart';
import 'package:movies/src/pages/movie_detail_page.dart';
import 'package:movies/src/pages/root.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<SearchMovieProvider>(
              create: (_) => SearchMovieProvider()),
          ChangeNotifierProvider<GlobalProvider>(
              create: (_) => GlobalProvider())
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Peliculas',
          routes: {
            '/': (BuildContext context) => RootPage(),
            'home': (BuildContext context) => HomePage(),
            'movie_detail': (BuildContext context) => MovieDetailPage(),
            'actor': (BuildContext context) => ActorPage(),
          },
          theme: ThemeData(fontFamily: 'Quicksand'),
          initialRoute: '/',
        ));
  }
}
