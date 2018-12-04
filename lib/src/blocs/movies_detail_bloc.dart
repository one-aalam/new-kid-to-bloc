import 'package:rxdart/rxdart.dart';
import 'dart:async';
import 'package:rxdart/subjects.dart';
import '../core/bloc.dart';
import '../models/movie_list_model.dart';
import '../resources/repository.dart';

class MoviesDetailBloc extends BlocBase {
  final _repository = Repository();
  final _movieDetailFetcher = PublishSubject<MovieItemModel>();


  Stream<MovieItemModel> get getMovieExt => _movieDetailFetcher.stream;

  fetchMovie(int id) async {
    MovieItemModel movieItemModel = await _repository.getMovie(id);
    _movieDetailFetcher.sink.add(movieItemModel);
  }

  dispose() {
    _movieDetailFetcher.close();
  }
}