import 'package:flutter/material.dart';

class Cast {
  List<Actor> items = List();
  Cast();
  Cast.fromJsonMap(List<dynamic> jsonList) {
    items.addAll(jsonList.map((e) => Actor.fromJsonMap(e)).toList());
  }
}

class Actor {
  int castId;
  String character;
  String creditId;
  int gender;
  int id;
  String name;
  int order;
  String profilePath;

  Actor({
    this.castId,
    this.character,
    this.creditId,
    this.gender,
    this.id,
    this.name,
    this.order,
    this.profilePath,
  });

  Actor.fromJsonMap(Map<String, dynamic> json) {
    castId = json['cast_idd'];
    character = json['character'];
    creditId = json['credit_id'];
    gender = json['gender'];
    id = json['id'];
    name = json['name'];
    order = json['order'];
    profilePath = json['profile_path'];
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
