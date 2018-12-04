class MovieGenreModel {
  final String text;
  final int genre;

  MovieGenreModel(
    this.text,
    this.genre
  );

  MovieGenreModel.fromJSON(Map<String, dynamic> json)
    : genre = json["id"],
      text  = json["name"];

}

class MovieTrailerModel {
  final String id;
  final String key;
  final String name;
  final String type;

  MovieTrailerModel(
    this.id,
    this.key,
    this.name,
    this.type
  );

  MovieTrailerModel.fromJSON(Map<String, dynamic> json)
    : id = json["id"],
      key  = json["key"],
      name = json["name"],
      type = json["type"];

}