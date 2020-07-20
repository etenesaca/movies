import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:movies/common/debouncer.dart';
import 'package:movies/src/models/movie_model.dart';
import 'package:movies/src/providers/movie_provider.dart';

class SearchMovieProvider with ChangeNotifier, DiagnosticableTreeMixin {
  final _debouncer = Debouncer();
  final _movieProvider = MovieProvider();

  List<Movie> _movies = [];
  List<Movie> get movies => _movies;

  bool _loading = false;
  bool get loading => _loading;

  void onChangeText(String query) {
    _debouncer.run(() {
      if (query.isNotEmpty && query.trim().length > 2) {
        requestSearch(query);
      }
    });
  }

  void requestSearch(String query) async {
    _loading = true;
    notifyListeners();

    _movies = await _movieProvider.getMoviesByName(query);
    print('Buscando: $query - Resultados. (${movies.length})');

    _loading = false;
    notifyListeners();
  }
}
