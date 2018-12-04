import './movie_genre.dart';

class MovieGenreListModel {
  List<MovieGenreModel> genres = <MovieGenreModel>[];

  MovieGenreListModel.fromJSON(Map<String, dynamic> json) {
    genres = (json["genres"] as List<dynamic>)
                .map(
                  (item) => MovieGenreModel.fromJSON(item)
                ).toList();
  }

  MovieGenreModel findById(int genre) => genres.firstWhere((g) => g.genre == genre);
}