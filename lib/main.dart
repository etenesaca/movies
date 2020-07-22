import 'package:flutter/material.dart';
import 'package:movies/src/pages/actor_page.dart';
import 'package:movies/src/pages/movie_poster_page.dart';
import 'package:movies/src/providers/global_provider.dart';
import 'package:movies/src/providers/search_provider.dart';
import 'package:movies/src/pages/home_page.dart';
import 'package:movies/src/pages/movie_detail_page.dart';
import 'package:movies/src/pages/root.dart';
import 'package:page_transition/page_transition.dart';
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
          },
          onGenerateRoute: (settings) {
            switch (settings.name) {
              case 'actor':
                return PageTransition(
                    child: ActorPage(),
                    type: PageTransitionType.rightToLeftWithFade,
                    settings: settings,
                    duration: Duration(milliseconds: 300));
                break;
              case 'movie_poster':
                return PageTransition(
                    child: MoviePosterPage(),
                    type: PageTransitionType.downToUp,
                    settings: settings,
                    duration: Duration(milliseconds: 300));
                break;
              default:
                return null;
            }
          },
          theme: ThemeData(fontFamily: 'Quicksand'),
          initialRoute: '/',
        ));
  }
}
