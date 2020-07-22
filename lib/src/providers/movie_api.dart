import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies/src/models/actor_model.dart';
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

  Future<List<Movie>> _getMoviesData(
    String apiUrl, {
    String callFrom = 'x',
    int page,
    String query,
    String language,
    String key = 'results',
  }) async {
    Map<String, String> queryParameters = {};
    if (page != null) queryParameters['page'] = '$page';
    if (query != null) queryParameters['query'] = query;
    if (language != null) queryParameters['language'] = language;
    final resJsonData = await _getHttpData(apiUrl, queryParameters);
    return Movies.fromJsonMap(resJsonData[key], callFrom).items;
  }

  Future<List<Movie>> getMoviesNowPlaying() async {
    return _getMoviesData('3/movie/now_playing', callFrom: 'now_playing');
  }

  Future<List<Movie>> getMoviesSection(String sectionName, int page) async {
    return _getMoviesData('3/movie/$sectionName',
        callFrom: sectionName, page: page);
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

  Future<List<Backdrop>> getMovieImagesList(int movieId) async {
    Map<String, String> queryParameters = {'language': '$_language,null'};
    final resJsonData =
        await _getHttpData('3/movie/$movieId/images', queryParameters);
    return Backdrops.fromJsonMap(resJsonData['backdrops']).items;
  }

  // Obtener los actores de la pelicula
  Future<List<Actor>> getMovieCast(int movieId) async {
    String apiUrl = '3/movie/$movieId/credits';
    Map<String, String> queryParameters = {};
    final resJsonData = await _getHttpData(apiUrl, queryParameters);
    return Cast.fromJsonMap(resJsonData['cast']).items;
  }

  // Obtener los detalles de un actor
  Future<Actor> getActorDetail(int actorId) async {
    String apiUrl = '3/person/$actorId';
    Map<String, String> queryParameters = {'language': 'en-US'};
    final resJsonData = await _getHttpData(apiUrl, queryParameters);
    return Actor.fromJsonMap(resJsonData);
  }

  // Portadas de un actor
  Future<List<Backdrop>> getActorImagesList(int actorId) async {
    Map<String, String> queryParameters = {'language': '$_language,null'};
    final resJsonData =
        await _getHttpData('3/person/$actorId/images', queryParameters);
    return Backdrops.fromJsonMap(resJsonData['profiles']).items;
  }

  // Obtener peliculas relacionadas a un actor
  Future<List<Movie>> getActorMovies(int actorId) async {
    return _getMoviesData('3/person/$actorId/movie_credits',
        callFrom: 'actor_movie', key: 'cast', language: '$_language,null');
  }
}