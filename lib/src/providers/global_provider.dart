import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:movies/src/models/gender_model.dart';
import 'package:movies/src/providers/movie_api.dart';

class GlobalProvider with ChangeNotifier, DiagnosticableTreeMixin {
  final _movieProvider = MovieProvider();

  List<MovieGenre> _allMovieGenres = [];
  List<MovieGenre> get allMovieGenres => _allMovieGenres;
  bool loading = false;

  void loadMovieGenders() async {
    loading = true;
    notifyListeners();
    _allMovieGenres = await _movieProvider.getGenreList();
    print('Cargando generos.');
    loading = false;
    notifyListeners();
  }
}