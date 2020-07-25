import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:movies/src/apis/the_movie_db_api.dart';
import 'package:movies/src/models/movie_model.dart';

class MovieDetailProvider with ChangeNotifier, DiagnosticableTreeMixin {
  MovieProvider movieApi = MovieProvider();

  bool loading = false;
  Movie movie;

  void getMovieDetails(int movieId) async {
    loading = true;
    notifyListeners();
    movie = await movieApi.getMovieDetail(movieId);
    loading = false;
    notifyListeners();
  }
}
