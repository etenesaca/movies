import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/blocs/preferences_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:movies/common/app_settings.dart';
import 'package:movies/src/pages/actor_page.dart';
import 'package:movies/src/pages/backdrop_page.dart';
import 'package:movies/src/pages/galery_page.dart';
import 'package:movies/src/pages/movie_videos.dart';
import 'package:movies/src/pages/play_trailer_page.dart';
import 'package:movies/src/providers/global_provider.dart';
import 'package:movies/src/providers/search_provider.dart';
import 'package:movies/src/pages/home_page.dart';
import 'package:movies/src/pages/movie_detail_page.dart';
import 'package:movies/src/pages/root.dart';
import 'package:page_transition/page_transition.dart';
import 'package:movies/generated/l10n.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final preferencesBloc = PreferencesBloc(
      initialLocale: await AppSettings().getLocaleApp(),
      initialLocaleMovies: await AppSettings().getLocaleMoviesApp());

  runApp(
    BlocProvider(
      create: (context) => preferencesBloc,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<SearchMovieProvider>(
              create: (_) => SearchMovieProvider()),
          ChangeNotifierProvider<GlobalProvider>(
              create: (_) => GlobalProvider()),
        ],
        child: BlocBuilder<PreferencesBloc, PreferencesState>(
          builder: (BuildContext context, state) {
            return buildMaterialApp(context, state);
          },
        ));
  }

  buildMaterialApp(BuildContext context, PreferencesState state) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        S.delegate,
        LocaleNamesLocalizationsDelegate(),
      ],
      supportedLocales: S.delegate.supportedLocales,
      locale: state.locale,
      debugShowCheckedModeBanner: false,
      title: 'Peliculas',
      routes: {
        '/': (BuildContext context) => RootPage(),
        'home': (BuildContext context) => HomePage(),
        'movie_detail': (BuildContext context) => MovieDetailPage(),
        'actor': (BuildContext context) => ActorPage(),
        'video_list': (BuildContext context) => VideoListPage(),
        'play_trailer': (BuildContext context) => PlayTrailerPage(),
        'movie_poster_child': (BuildContext context) => MoviePosterPage(),
      },
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          /* 
              case 'actor':
                return PageTransition(
                    child: ActorPage(),
                    type: PageTransitionType.rightToLeftWithFade,
                    settings: settings,
                    duration: Duration(milliseconds: 300));
                break;
              */
          case 'movie_poster':
            return PageTransition(
                child: MoviePosterPage(),
                type: PageTransitionType.downToUp,
                settings: settings,
                duration: Duration(milliseconds: 300));
            break;
          case 'galery':
            return PageTransition(
                child: GaleryPage(),
                type: PageTransitionType.downToUp,
                settings: settings,
                duration: Duration(milliseconds: 300));
            break;
          default:
            return null;
        }
      },
      theme: ThemeData(fontFamily: 'Quicksand'),
    );
  }
}
