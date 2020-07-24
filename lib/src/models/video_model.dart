class Videos {
  List<Video> items = List();
  Videos();
  Videos.fromJsonMap(List<dynamic> jsonList) {
    items.addAll(jsonList.map((e) => Video.fromJsonMap(e)));
  }
}

class Video {
  String id;
  String iso6391;
  String iso31661;
  String key;
  String name;
  String site;
  int size;
  String type;

  Video({
    this.id,
    this.iso6391,
    this.iso31661,
    this.key,
    this.name,
    this.site,
    this.size,
    this.type,
  });

  Video.fromJsonMap(Map<String, dynamic> json) {
    id = json['id'];
    iso6391 = json['iso6391'];
    iso31661 = json['iso31661'];
    key = json['key'];
    name = json['name'];
    site = json['site'];
    size = json['size'];
    type = json['type'];
  }
}
