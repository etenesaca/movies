import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/blocs/preferences_bloc.dart';
import 'package:movies/common/app_settings.dart';
import 'package:movies/env/app_env.dart';
import 'package:movies/locator.dart';
import 'package:movies/main.dart';

void main() async {
  setupLocator();
  AppEnvironment.setupEnv(Environment.prod);

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
