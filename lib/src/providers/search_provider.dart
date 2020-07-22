import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:movies/common/debouncer.dart';
import 'package:movies/src/models/movie_model.dart';
import 'package:movies/src/providers/movie_api.dart';

class SearchMovieProvider with ChangeNotifier, DiagnosticableTreeMixin {
  final _debouncer = Debouncer();
  final _movieProvider = MovieProvider();

  List<Movie> _movies = [];
  List<Movie> get movies => _movies;

  bool loading = false;
  bool noHasResults = false;

  void onChangeText(String query) {
    query = query.trim().toLowerCase();
    _debouncer.run(() {
      if (query.isNotEmpty && query.trim().length > 2) {
        requestSearch(query);
      }
    }, 1500);
  }

  TextEditingController txtSearchController = TextEditingController();
  void clearInputField() {
    noHasResults = false;
    txtSearchController.clear();
    _movies = [];
    notifyListeners();
  }

  void requestSearch(String query) async {
    loading = true;
    noHasResults = false;
    notifyListeners();

    _movies = await _movieProvider.getMoviesByName(query);
    if (_movies.isEmpty) {
      noHasResults = true;
    }
    print('Buscando: $query - Resultados. (${movies.length})');

    loading = false;
    notifyListeners();
  }
}
