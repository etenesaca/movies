import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies/src/models/movie_model.dart';

class MovieProvider {
  String _apikey = '0c87c373e9ddc6969a2751ea710b2b0c';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  Future<dynamic> getHttpData(
      String apiUrl, Map<String, String> queryParameters) async {
    queryParameters['apikey'] = _apikey;
    queryParameters['language'] = _language;
    final url = Uri.https(_url, apiUrl, queryParameters);
    final resp = await http.get(url);
    return json.decode(resp.body);
  }

  Future<List<Movie>> getMoviesData(String apiUrl, String callFrom,
      [int page, String query]) async {
    Map<String, String> queryParameters = {};
    if (page != null) {
      queryParameters['page'] = '$page';
    }
    if (query != null) {
      queryParameters['query'] = query;
    }
    final resJsonData = await getHttpData(apiUrl, queryParameters);
    return Movies.fromJsonMap(resJsonData['results'], callFrom).items;
  }

  Future<List<Movie>> getMoviesNowPlaying() async {
    return getMoviesData('3/movie/now_playing', 'now_playing', 1);
  }

  Future<List<Movie>> getMoviesByName(String query) async {
    return getMoviesData('3/search/movie', 'search', null, query);
  }
}
