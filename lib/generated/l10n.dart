// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Now playing`
  String get nowPlaying {
    return Intl.message(
      'Now playing',
      name: 'nowPlaying',
      desc: '',
      args: [],
    );
  }

  /// `Populars`
  String get section_popular {
    return Intl.message(
      'Populars',
      name: 'section_popular',
      desc: '',
      args: [],
    );
  }

  /// `Top rated`
  String get section_top_rated {
    return Intl.message(
      'Top rated',
      name: 'section_top_rated',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `System language`
  String get systemLanguage {
    return Intl.message(
      'System language',
      name: 'systemLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Movies language`
  String get moviesLanguage {
    return Intl.message(
      'Movies language',
      name: 'moviesLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Galery`
  String get galery {
    return Intl.message(
      'Galery',
      name: 'galery',
      desc: '',
      args: [],
    );
  }

  /// `Show all`
  String get show_all {
    return Intl.message(
      'Show all',
      name: 'show_all',
      desc: '',
      args: [],
    );
  }

  /// `Trailers`
  String get trailers {
    return Intl.message(
      'Trailers',
      name: 'trailers',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Change language`
  String get change_language {
    return Intl.message(
      'Change language',
      name: 'change_language',
      desc: '',
      args: [],
    );
  }

  /// `Change password`
  String get change_password {
    return Intl.message(
      'Change password',
      name: 'change_password',
      desc: '',
      args: [],
    );
  }

  /// `About`
  String get about_app {
    return Intl.message(
      'About',
      name: 'about_app',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `New movies`
  String get new_movies {
    return Intl.message(
      'New movies',
      name: 'new_movies',
      desc: '',
      args: [],
    );
  }

  /// `Receive notifications`
  String get notifications_active {
    return Intl.message(
      'Receive notifications',
      name: 'notifications_active',
      desc: '',
      args: [],
    );
  }

  /// `Application`
  String get application {
    return Intl.message(
      'Application',
      name: 'application',
      desc: '',
      args: [],
    );
  }

  /// `Movies`
  String get movies {
    return Intl.message(
      'Movies',
      name: 'movies',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `No images available`
  String get no_images_available {
    return Intl.message(
      'No images available',
      name: 'no_images_available',
      desc: '',
      args: [],
    );
  }

  /// `Saved`
  String get saved {
    return Intl.message(
      'Saved',
      name: 'saved',
      desc: '',
      args: [],
    );
  }

  /// `My list`
  String get myList {
    return Intl.message(
      'My list',
      name: 'myList',
      desc: '',
      args: [],
    );
  }

  /// `Show more`
  String get show_more {
    return Intl.message(
      'Show more',
      name: 'show_more',
      desc: '',
      args: [],
    );
  }

  /// `Show less`
  String get show_less {
    return Intl.message(
      'Show less',
      name: 'show_less',
      desc: '',
      args: [],
    );
  }

  /// `Actors`
  String get actors {
    return Intl.message(
      'Actors',
      name: 'actors',
      desc: '',
      args: [],
    );
  }

  /// `Most popular`
  String get most_popular {
    return Intl.message(
      'Most popular',
      name: 'most_popular',
      desc: '',
      args: [],
    );
  }

  /// `Populars`
  String get populars {
    return Intl.message(
      'Populars',
      name: 'populars',
      desc: '',
      args: [],
    );
  }

  /// `Top rated`
  String get top_rated {
    return Intl.message(
      'Top rated',
      name: 'top_rated',
      desc: '',
      args: [],
    );
  }

  /// `Search a movie`
  String get search_a_movie {
    return Intl.message(
      'Search a movie',
      name: 'search_a_movie',
      desc: '',
      args: [],
    );
  }

  /// `We don't have this movie for now.`
  String get dont_have_this_movie {
    return Intl.message(
      'We don\'t have this movie for now.',
      name: 'dont_have_this_movie',
      desc: '',
      args: [],
    );
  }

  /// `Try looking for another movie`
  String get try_search_other_movie {
    return Intl.message(
      'Try looking for another movie',
      name: 'try_search_other_movie',
      desc: '',
      args: [],
    );
  }

  /// `Coming soon`
  String get coming {
    return Intl.message(
      'Coming soon',
      name: 'coming',
      desc: '',
      args: [],
    );
  }

  /// `Information`
  String get info {
    return Intl.message(
      'Information',
      name: 'info',
      desc: '',
      args: [],
    );
  }

  /// `Trailer`
  String get trailer {
    return Intl.message(
      'Trailer',
      name: 'trailer',
      desc: '',
      args: [],
    );
  }

  /// `Rating`
  String get rating {
    return Intl.message(
      'Rating',
      name: 'rating',
      desc: '',
      args: [],
    );
  }

  /// `Rate`
  String get rate {
    return Intl.message(
      'Rate',
      name: 'rate',
      desc: '',
      args: [],
    );
  }

  /// `Genres`
  String get genres {
    return Intl.message(
      'Genres',
      name: 'genres',
      desc: '',
      args: [],
    );
  }

  /// `Release date`
  String get release_date {
    return Intl.message(
      'Release date',
      name: 'release_date',
      desc: '',
      args: [],
    );
  }

  /// `Votes`
  String get votes {
    return Intl.message(
      'Votes',
      name: 'votes',
      desc: '',
      args: [],
    );
  }

  /// `Principal actors`
  String get principal_actors {
    return Intl.message(
      'Principal actors',
      name: 'principal_actors',
      desc: '',
      args: [],
    );
  }

  /// `Similars`
  String get similars {
    return Intl.message(
      'Similars',
      name: 'similars',
      desc: '',
      args: [],
    );
  }

  /// `Synopsis`
  String get synopsis {
    return Intl.message(
      'Synopsis',
      name: 'synopsis',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `Date of birth`
  String get date_of_birth {
    return Intl.message(
      'Date of birth',
      name: 'date_of_birth',
      desc: '',
      args: [],
    );
  }

  /// `Movies in which appears`
  String get actor_related_movies {
    return Intl.message(
      'Movies in which appears',
      name: 'actor_related_movies',
      desc: '',
      args: [],
    );
  }

  /// `Biography`
  String get biography {
    return Intl.message(
      'Biography',
      name: 'biography',
      desc: '',
      args: [],
    );
  }

  /// `There are no trailers for this movie`
  String get no_has_videos {
    return Intl.message(
      'There are no trailers for this movie',
      name: 'no_has_videos',
      desc: '',
      args: [],
    );
  }

  /// `Suggested`
  String get suggested {
    return Intl.message(
      'Suggested',
      name: 'suggested',
      desc: '',
      args: [],
    );
  }

  /// `No movies`
  String get no_has_movies {
    return Intl.message(
      'No movies',
      name: 'no_has_movies',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'es'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}