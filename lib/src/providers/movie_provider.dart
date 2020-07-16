import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies/src/models/gender_model.dart';
import 'package:movies/src/models/image_model.dart';
import 'package:movies/src/models/movie_model.dart';

class MovieProvider {
  String _apikey = '0c87c373e9ddc6969a2751ea710b2b0c';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  Future<dynamic> _getHttpData(
      String apiUrl, Map<String, String> queryParameters) async {
    queryParameters['api_key'] = _apikey;
    if (!queryParameters.keys.contains('language')) {
      queryParameters['language'] = _language;
    }
    final url = Uri.https(_url, apiUrl, queryParameters);
    final resp = await http.get(url);
    return json.decode(resp.body);
  }

  Future<List<Movie>> _getMoviesData(String apiUrl,
      {String callFrom = 'x', int page, String query}) async {
    Map<String, String> queryParameters = {};
    if (page != null) queryParameters['page'] = '$page';
    if (query != null) queryParameters['query'] = query;
    final resJsonData = await _getHttpData(apiUrl, queryParameters);
    return Movies.fromJsonMap(resJsonData['results'], callFrom).items;
  }

  Future<List<Movie>> getMoviesNowPlaying() async {
    return _getMoviesData('3/movie/now_playing', callFrom: 'now_playing');
  }

  Future<List<Movie>> getMoviesPopulars(int page) async {
    return _getMoviesData('3/movie/popular', callFrom: 'popular', page: page);
  }

  Future<List<Movie>> getMoviesByName(String query) async {
    return _getMoviesData('3/search/movie', query: query);
  }

  Future<List<MovieGenre>> getGenreList() async {
    Map<String, String> queryParameters = {};
    final resJsonData =
        await _getHttpData('3/genre/movie/list', queryParameters);
    return MovieGenres.fromJsonMap(resJsonData['genres']).items;
  }

  Future<List<Backdrop>> getImagesList(int movieId) async {
    Map<String, String> queryParameters = {'language': '$_language,null'};
    final resJsonData =
        await _getHttpData('3/movie/${movieId}/images', queryParameters);
    return Backdrops.fromJsonMap(resJsonData['backdrops']).items;
  }
}
