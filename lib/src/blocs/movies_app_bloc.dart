import 'package:rxdart/rxdart.dart';
import 'dart:async';
import 'package:rxdart/subjects.dart';
import '../core/bloc.dart';
import '../models/movie_genre_list.dart';
import '../resources/repository.dart';

class MoviesAppBloc extends BlocBase {
  final _repository = Repository();
  final _moviesGenreFetcher = PublishSubject<MovieGenreListModel>();


  Stream<MovieGenreListModel> get getGenres => _moviesGenreFetcher.stream;

  fetchAllGenres() async {
    MovieGenreListModel movieGenreListModel = await _repository.getGenres();
    _moviesGenreFetcher.sink.add(movieGenreListModel);
  }

  dispose() {
    _moviesGenreFetcher.close();
  }
}