import 'dart:async';
import 'movie_api_provider.dart';
import '../models/movie_list_model.dart';

class Repository {
  final movieService = MovieService();
  Future<MovieListModel> getAllMovies() => movieService.getMovies();
}