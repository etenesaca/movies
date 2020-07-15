import 'dart:async';

import 'package:movies/src/models/movie_model.dart';
import 'package:movies/src/providers/movie_provider.dart';

class MoviePopularBloc {
  // Stream de Datos Para paginación de populares.
  MovieProvider _movieProvider = MovieProvider();
  int _popularesPage = 0;
  bool _loadingPopularsData = false;
  List<Movie> _populars = [];
  final _popularsStremController = StreamController<List<Movie>>.broadcast();
  // Sink
  Function(List<Movie>) get popularesSink => _popularsStremController.sink.add;
  Stream<List<Movie>> get popularesStream => _popularsStremController.stream;

  Future<List<Movie>> getNextPage() async {
    if (_loadingPopularsData) return [];
    _loadingPopularsData = true;
    _popularesPage++;
    print('Bloc - Loading Popular Data: Page $_popularesPage');
    final res = await _movieProvider.getMoviesPopulars(_popularesPage);
    _populars.addAll(res);
    popularesSink(_populars);
    _loadingPopularsData = false;
    return res;
  }

  void disposeStream() {
    _popularsStremController?.close();
  }
}
