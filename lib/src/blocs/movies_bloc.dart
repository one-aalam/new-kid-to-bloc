import 'package:rxdart/rxdart.dart';
import 'dart:async';
import 'package:rxdart/subjects.dart';
import '../models/movie_list_model.dart';
import '../resources/repository.dart';

class MoviesBloc {
  final _repository = Repository();
  final _moviesFetcher = PublishSubject<MovieListModel>();

  // Observable<MovieListModel> getMovies => _moviesFetcher.stream;
  Stream<MovieListModel> get getMovies => _moviesFetcher.stream;


  fetchAllMovies() async {
    MovieListModel movieListModel = await _repository.getAllMovies();
    _moviesFetcher.sink.add(movieListModel);
  }

  dispose() {
    _moviesFetcher.close();
  }
}


final bloc = MoviesBloc();