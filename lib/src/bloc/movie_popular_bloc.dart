import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:movies/src/models/movie_model.dart';
import 'package:movies/src/providers/movie_provider.dart';

class MovieSectionBloc {
  final sectionName;
  MovieSectionBloc(this.sectionName);

  // Stream de Datos Para paginación de populares.
  MovieProvider _movieProvider = MovieProvider();
  int _sectionPage = 0;
  bool _loadingData = false;
  List<Movie> _movies = [];
  final _stremController = StreamController<List<Movie>>.broadcast();
  // Sink
  Function(List<Movie>) get movieSink => _stremController.sink.add;
  Stream<List<Movie>> get moviesStream => _stremController.stream;

  Future<List<Movie>> getNextPage() async {
    if (_loadingData) return [];
    _loadingData = true;
    _sectionPage++;
    print('Bloc - Loading Section Movies: Page $_sectionPage');
    final res =
        await _movieProvider.getMoviesSection(sectionName, _sectionPage);
    _movies.addAll(res);
    movieSink(_movies);
    _loadingData = false;
    return res;
  }

  void disposeStream() {
    _stremController?.close();
  }
}
