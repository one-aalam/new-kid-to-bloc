import 'package:rxdart/rxdart.dart';
import 'dart:async';
import 'package:rxdart/subjects.dart';
import '../core/bloc.dart';
import '../models/movie_list_model.dart';
import '../resources/repository.dart';

class MoviesBloc extends BlocBase {
  final _repository = Repository();
  final _moviesFetcher = PublishSubject<MovieListModel>();

  Stream<MovieListModel> get getMovies => _moviesFetcher.stream;

  fetchAllMovies() async {
    MovieListModel movieListModel = await _repository.getAllMovies();
    _moviesFetcher.sink.add(movieListModel);
  }

  dispose() {
    _moviesFetcher.close();
  }
}