// Generated by https://quicktype.io

import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

class Movies {
  List<Movie> items = List();
  Movies();
  Movies.fromJsonMap(List<dynamic> jsonList, String callFrom) {
    jsonList.forEach((x) {
      items.add(Movie.fromJsonMap(x, callFrom));
    });
  }
}

class Movie {
  double popularity;
  int voteCount;
  bool video;
  String posterPath;
  int id;
  String idHero;
  bool adult;
  String backdropPath;
  String originalLanguage;
  String originalTitle;
  List<int> genreIds;
  String title;
  double voteAverage;
  String overview;
  String releaseDate;

  Movie({
    this.voteCount,
    this.popularity,
    this.video,
    this.posterPath,
    this.id,
    this.idHero,
    this.adult,
    this.backdropPath,
    this.originalLanguage,
    this.originalTitle,
    this.genreIds,
    this.title,
    this.voteAverage,
    this.overview,
    this.releaseDate,
  });

  Movie.fromJsonMap(Map<String, dynamic> json, String callFrom) {
    voteCount = json['vote_count'];
    popularity = json['popularity'];
    video = json['video'];
    posterPath = json['poster_path'];
    id = json['id'];
    idHero = '${json['id']}_$callFrom';
    adult = json['adult'];
    backdropPath = json['backdrop_path'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    genreIds = json['genre_ids'];
    title = json['title'];
    voteAverage = json['vote_average'];
    overview = json['overview'];
    releaseDate = json['release_date'];
  }

  String getPosterImgUrl() {
    final res = (posterPath != null)
        ? 'https://www.digopaul.com/wp-content/uploads/related_images/2015/09/08/placeholder_2.jpg'
        : 'https://image.tmdb.org/t/p/w500/$posterPath';
    return res;
  }

  NetworkImage getPosterImg() => NetworkImage(getPosterImgUrl());

  String getBackgroundImgUrl() {
    final res = (backdropPath != null)
        ? 'https://www.digopaul.com/wp-content/uploads/related_images/2015/09/08/placeholder_2.jpg'
        : 'https://image.tmdb.org/t/p/w500/$backdropPath';
    return res;
  }

  NetworkImage getBackgroundImg() => NetworkImage(getBackgroundImgUrl());
}
