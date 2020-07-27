import 'dart:async';

import 'package:movies/src/models/movie_model.dart';
import 'package:movies/src/apis/the_movie_db_api.dart';

class MoviePopularBloc {
  final sectionName = 'popular';

  // Stream de Datos Para paginación de populares.
  MovieProvider _movieProvider = MovieProvider();
  int _page = 0;
  bool _loadingData = false;
  List<Movie> _movies = [];
  final _stremController = StreamController<List<Movie>>.broadcast();
  // Sink
  Function(List<Movie>) get movieSink => _stremController.sink.add;
  Stream<List<Movie>> get moviesStream => _stremController.stream;

  Future<List<Movie>> getNextPage() async {
    if (_loadingData || _stremController.isClosed) return [];
    _loadingData = true;
    _page++;
    final res = await _movieProvider.getMoviesSection(sectionName, _page);
    _movies.addAll(res);
    movieSink(_movies);
    _loadingData = false;
    return res;
  }

  void dispose() {
    _stremController?.close();
  }
}

class MovieTopRatedBloc {
  final sectionName = 'top_rated';

  // Stream de Datos Para paginación de populares.
  MovieProvider _movieProvider = MovieProvider();
  int _page = 0;
  bool _loadingData = false;
  List<Movie> _movies = [];
  final _stremController = StreamController<List<Movie>>.broadcast();
  // Sink
  Function(List<Movie>) get movieSink => _stremController.sink.add;
  Stream<List<Movie>> get moviesStream => _stremController.stream;

  Future<List<Movie>> getNextPage() async {
    if (_loadingData || _stremController.isClosed) return [];
    _loadingData = true;
    _page++;
    final res = await _movieProvider.getMoviesSection(sectionName, _page);
    _movies.addAll(res);
    movieSink(_movies);
    _loadingData = false;
    return res;
  }

  void dispose() {
    _stremController?.close();
  }
}

class MovieUpcomingBloc {
  final sectionName = 'upcoming';

  // Stream de Datos Para paginación de populares.
  MovieProvider _movieProvider = MovieProvider();
  int _page = 0;
  bool _loadingData = false;
  List<Movie> _movies = [];
  final _stremController = StreamController<List<Movie>>.broadcast();
  // Sink
  Function(List<Movie>) get movieSink => _stremController.sink.add;
  Stream<List<Movie>> get moviesStream => _stremController.stream;

  Future<List<Movie>> getNextPage() async {
    if (_loadingData || _stremController.isClosed) return [];
    _loadingData = true;
    _page++;
    final res = await _movieProvider.getMoviesSection(sectionName, _page);
    _movies.addAll(res);
    movieSink(_movies);
    _loadingData = false;
    return res;
  }

  void dispose() {
    _stremController?.close();
  }
}
