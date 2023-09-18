import 'package:flutter/material.dart';

class Cast {
  List<Actor> items = [];
  Cast();
  Cast.fromJsonMap(List<dynamic> jsonList) {
    items.addAll(jsonList.map((e) => Actor.fromJsonMap(e)).toList());
  }
}

class Actor {
  String? birthday;
  String? knownForDepartment;
  String? deathday;
  int? id;
  String? name;
  List<dynamic>? alsoKnownAs;
  int? gender;
  String? biography;
  double? popularity;
  String? placeOfBirth;
  String? profilePath;
  bool? adult;
  String? imdbId;
  dynamic? homepage;
  String? idHero;

  int? castId;
  String? character;
  String? creditId;
  int? order;

  Actor({
    this.castId,
    this.character,
    this.creditId,
    this.gender,
    this.id,
    this.idHero,
    this.name,
    this.order,
    this.profilePath,
  });

  Actor.fromJsonMap(Map<String, dynamic> json) {
    order = json['order'];
    castId = json['cast_id'];
    character = json['character'];
    creditId = json['credit_id'];

    gender = json['gender'];
    id = json['id'];
    idHero = 'AC_${json['id']}';
    name = json['name'];
    profilePath = json['profile_path'];
    birthday = json['birthday'];
    knownForDepartment = json['known_for_department'];
    deathday = json['deathday'];
    id = json['id'];
    name = json['name'];
    alsoKnownAs = json['also_known_as'];
    gender = json['gender'];
    biography = json['biography'];
    popularity =
        (!json.keys.contains('popularity')) ? 0.0 : json['popularity'] / 1;
    placeOfBirth = json['place_of_birth'];
    profilePath = json['profile_path'];
    adult = json['adult'];
    imdbId = json['imdb_id'];
    homepage = json['homepage'];
  }

  String getPhotoImgUrl() {
    final res = (profilePath == null)
        ? 'https://www.digopaul.com/wp-content/uploads/related_images/2015/09/08/placeholder_2.jpg'
        : 'https://image.tmdb.org/t/p/w500/$profilePath';
    return res;
  }

  NetworkImage getPhotoImg() => NetworkImage(getPhotoImgUrl());

  String getPhotoImgSmallUrl() {
    final res = (profilePath == null)
        ? 'https://www.digopaul.com/wp-content/uploads/related_images/2015/09/08/placeholder_2.jpg'
        : 'https://image.tmdb.org/t/p/w200/$profilePath';
    return res;
  }

  NetworkImage getPhotoImgSmall() => NetworkImage(getPhotoImgSmallUrl());
}
