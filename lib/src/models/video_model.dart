class Videos {
  List<Video> items = [];
  Videos();
  Videos.fromJsonMap(List<dynamic> jsonList, String language) {
    items.addAll(jsonList.map((e) => Video.fromJsonMap(e, language)));
  }
}

class Video {
  String? id;
  String? iso6391;
  String? iso31661;
  String? key;
  String? name;
  String? site;
  int? size;
  String? type;
  String? lang;

  Video({
    this.id,
    this.iso6391,
    this.iso31661,
    this.key,
    this.name,
    this.site,
    this.size,
    this.type,
    this.lang,
  });

  Video.fromJsonMap(Map<String, dynamic> json, String language) {
    id = json['id'];
    iso6391 = json['iso6391'];
    iso31661 = json['iso31661'];
    key = json['key'];
    name = json['name'];
    site = json['site'];
    size = json['size'];
    type = json['type'];
    //lang = (language.toLowerCase().startsWith('es-')) ? 'Español' : language;
    lang = language;
  }
}
