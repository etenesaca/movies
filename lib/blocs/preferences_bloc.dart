import 'dart:async';
import 'dart:ui';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/common/app_settings.dart';

abstract class PreferencesEvent extends Equatable {}

class ChangeLocale extends PreferencesEvent {
  final String locale;
  final String localeMovies;
  final bool useSysLanguage;

  ChangeLocale({this.locale, this.localeMovies, this.useSysLanguage});

  @override
  List<Object> get props => [locale, localeMovies, useSysLanguage];
}

class PreferencesState extends Equatable {
  final Locale locale;
  final Locale localeMovies;
  final bool useSysLanguage;

  PreferencesState(
      {@required this.locale,
      @required this.localeMovies,
      @required this.useSysLanguage});
  @override
  List<Object> get props => [locale, localeMovies, useSysLanguage];
}

class PreferencesBloc extends Bloc<PreferencesEvent, PreferencesState> {
  final PreferencesState _initialState;

  PreferencesBloc({
    @required Locale initialLocale,
    @required Locale initialLocaleMovies,
    @required bool initialuseSysLanguage,
  })  : assert(initialLocale != null),
        _initialState = PreferencesState(
            locale: initialLocale,
            localeMovies: initialLocaleMovies,
            useSysLanguage: initialuseSysLanguage),
        super(null);

  @override
  PreferencesState get state => _initialState;

  @override
  Stream<PreferencesState> mapEventToState(
    PreferencesEvent event,
  ) async* {
    final appSettings = AppSettings();
    if (event is ChangeLocale) {
      bool useSysLanguage = event.useSysLanguage;
      if (event.locale == null || event.localeMovies == null) {
        useSysLanguage = true;
      }
      await appSettings.setLangApp(event.locale);
      await appSettings.setLangMovies(event.localeMovies);
      await appSettings.useSysLanguage(useSysLanguage);
      // Actualizar stream
      yield PreferencesState(
          locale: appSettings.string2Locale(event.locale),
          localeMovies: appSettings.string2Locale(event.localeMovies),
          useSysLanguage: useSysLanguage);
    }
  }
}
