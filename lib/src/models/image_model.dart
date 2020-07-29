import 'package:flutter/material.dart';

class Backdrops {
  List<Backdrop> items = List();
  Backdrops();
  Backdrops.fromJsonMap(List<dynamic> jsonList) {
    items.addAll(jsonList.map((e) => Backdrop.fromJsonMap(e)).toList());
  }
}

class Backdrop {
  double aspectRatio;
  String filePath;
  int height;
  dynamic iso6391;
  double voteAverage;
  int voteCount;
  int width;

  Backdrop({
    this.aspectRatio,
    this.filePath,
    this.height,
    this.iso6391,
    this.voteAverage,
    this.voteCount,
    this.width,
  });

  Backdrop.fromJsonMap(Map<String, dynamic> json) {
    aspectRatio = json['aspect_ratio'] / 1;
    filePath = json['file_path'];
    height = json['height'];
    iso6391 = json['iso6391'];
    voteAverage = json['vote_average'] / 1;
    voteCount = json['vote_count'];
    width = json['width'];
  }

  String getPathUrl() {
    final res = (filePath == null)
        ? 'https://www.digopaul.com/wp-content/uploads/related_images/2015/09/08/placeholder_2.jpg'
        : 'https://image.tmdb.org/t/p/w500/$filePath';
    return res;
  }

  NetworkImage getImg() => NetworkImage(getPathUrl());

  String getSmallPathUrl() {
    final res = (filePath == null)
        ? 'https://www.digopaul.com/wp-content/uploads/related_images/2015/09/08/placeholder_2.jpg'
        : 'https://image.tmdb.org/t/p/w300/$filePath';
    return res;
  }

  NetworkImage getImgSmall() => NetworkImage(getSmallPathUrl());

  String getLargePathUrl() {
    final res = (filePath == null)
        ? 'https://www.digopaul.com/wp-content/uploads/related_images/2015/09/08/placeholder_2.jpg'
        : 'https://image.tmdb.org/t/p/original/$filePath';
    return res;
  }

  NetworkImage getImgLarge() => NetworkImage(getLargePathUrl());
}
