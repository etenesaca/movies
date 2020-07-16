class MovieGenres {
  List<MovieGenre> items = List();
  MovieGenres();
  MovieGenres.fromJsonMap(List<dynamic> jsonList) {
    items.addAll(jsonList.map((e) => MovieGenre.fromJsonMap(e)).toList());
  }
}

class MovieGenre {
  int id;
  String name;

  MovieGenre({
    this.id,
    this.name,
  });

  MovieGenre.fromJsonMap(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}
