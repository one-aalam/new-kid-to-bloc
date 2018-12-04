import 'dart:async';
import 'movie_api_provider.dart';
import '../models/movie_list_model.dart';
import '../models/movie_genre_list.dart';

class Repository {
  final movieService = MovieService();
  Future<MovieListModel> getAllMovies() => movieService.getMovies();
  Future<MovieItemModel> getMovie(int id) => movieService.getMovie(id);
  Future<TvListModel> getAllTvs() => movieService.getTvs();
  Future<MovieGenreListModel> getGenres() => movieService.getGenres();
}