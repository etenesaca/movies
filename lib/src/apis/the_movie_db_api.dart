import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies/common/app_settings.dart';
import 'package:movies/src/models/actor_model.dart';
import 'package:movies/src/models/gender_model.dart';
import 'package:movies/src/models/image_model.dart';
import 'package:movies/src/models/movie_model.dart';
import 'package:movies/src/models/video_model.dart';

class MovieProvider {
  String _apikey = '0c87c373e9ddc6969a2751ea710b2b0c';
  String _url = 'api.themoviedb.org';
  String _oriLanguaje = 'en-US';

  Future<dynamic> _getHttpData(
      String apiUrl, Map<String, String> queryParameters) async {
    queryParameters['api_key'] = _apikey;
    if (!queryParameters.keys.contains('language')) {
      queryParameters['language'] = await AppSettings().getLangMovies();
    }
    if (!queryParameters.keys.contains('addLanguage')) {
      queryParameters['language'] =
          '${queryParameters['language']},${queryParameters['addLanguage']}';
    }
    apiUrl = '3$apiUrl';
    final url = Uri.https(_url, apiUrl, queryParameters);
    final resp = await http.get(url);
    return json.decode(resp.body);
  }

  Future<List<Movie>> _getMoviesData(
    String apiUrl, {
    String callFrom = 'x',
    int page,
    String query,
    String addLanguage,
    String key = 'results',
  }) async {
    Map<String, String> queryParameters = {};
    if (page != null) queryParameters['page'] = '$page';
    if (query != null) queryParameters['query'] = query;
    if (addLanguage != null) queryParameters['addLanguage'] = addLanguage;
    final resJsonData = await _getHttpData(apiUrl, queryParameters);
    return Movies.fromJsonMap(resJsonData[key], callFrom).items;
  }

  Future<List<Movie>> getMoviesNowPlaying() async {
    return _getMoviesData('/movie/now_playing', callFrom: 'now_playing');
  }

  Future<List<Movie>> getMoviesSection(String sectionName, int page) async {
    return _getMoviesData('/movie/$sectionName',
        callFrom: sectionName, page: page);
  }

  Future<List<Movie>> getMoviesByName(String query) async {
    return _getMoviesData('/search/movie', query: query);
  }

  Future<List<MovieGenre>> getGenreList() async {
    final resJsonData = await _getHttpData('/genre/movie/list', {});
    return MovieGenres.fromJsonMap(resJsonData['genres']).items;
  }

  Future<List<Backdrop>> getMovieImagesList(int movieId) async {
    final resJsonData = await _getHttpData('/movie/$movieId/images', {});
    return Backdrops.fromJsonMap(resJsonData['backdrops']).items;
  }

  // Obtener los actores de la pelicula
  Future<List<Actor>> getMovieCast(int movieId) async {
    String apiUrl = '/movie/$movieId/credits';
    final resJsonData = await _getHttpData(apiUrl, {});
    return Cast.fromJsonMap(resJsonData['cast']).items;
  }

  // Obtener las peliculas relacionadas
  Future<List<Movie>> getMovieRecommendeds(int movieId) async {
    return _getMoviesData('/movie/$movieId/recommendations',
        callFrom: 'movie_related', addLanguage: 'null');
  }

  // Obtener las peliculas similares
  Future<List<Movie>> getMovieSimilars(int movieId) async {
    return _getMoviesData('/movie/$movieId/similar',
        callFrom: 'movie_similar', addLanguage: 'null');
  }

  // Obtener una lista de video relacionado a una pelicula
  Future<List<Video>> getVideosByLanguage(int movieId, String language) async {
    String apiUrl = '/movie/$movieId/videos';
    final resJsonData = await _getHttpData(apiUrl, {'language': language});
    return Videos.fromJsonMap(resJsonData['results'], language).items;
  }

  Future<List<Video>> getVideos(int movieId) async {
    List<Video> res = [];
    final defLanguage = await AppSettings().getLangMovies();
    final langDef = await getVideosByLanguage(movieId, defLanguage);
    res.addAll(langDef);
    if (defLanguage != _oriLanguaje) {
      final oriLang = await getVideosByLanguage(movieId, _oriLanguaje);
      res.addAll(oriLang);
    }
    return res;
  }

  // Obtener los detalles de una pelicula
  Future<Movie> getMovieDetail(int movieId) async {
    String apiUrl = '/movie/$movieId';
    final resJsonData = await _getHttpData(apiUrl, {'language': _oriLanguaje});
    return Movie.fromJsonMap(resJsonData, 'movie_detail');
  }

  Future<Movie> getLastMovie() async {
    String apiUrl = '/movie/latest';
    final resJsonData = await _getHttpData(apiUrl, {});
    return Movie.fromJsonMap(resJsonData, 'new_movie');
  }

  // Portadas de un actor
  Future<List<Backdrop>> getActorImagesList(int actorId) async {
    final resJsonData =
        await _getHttpData('/person/$actorId/images', {'addLanguage': 'null'});
    return Backdrops.fromJsonMap(resJsonData['profiles']).items;
  }

  // Obtener peliculas relacionadas a un actor
  Future<List<Movie>> getActorMovies(Actor actor) async {
    return _getMoviesData('/person/${actor.id}/movie_credits',
        callFrom: 'actor_movie_${actor.idHero}',
        key: 'cast',
        addLanguage: 'null');
  }

  // Obtener los detalles de un actor
  Future<Actor> getActorDetail(int actorId) async {
    String apiUrl = '/person/$actorId';
    final resJsonData = await _getHttpData(apiUrl, {'language': _oriLanguaje});
    return Actor.fromJsonMap(resJsonData);
  }

  // Obtener los actores de la pelicula
  Future<List<Actor>> getPopularActors() async {
    String apiUrl = '/person/popular';
    final resJsonData = await _getHttpData(apiUrl, {});
    return Cast.fromJsonMap(resJsonData['results']).items;
  }
}
