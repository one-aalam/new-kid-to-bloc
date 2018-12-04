import 'dart:async';
import 'dart:collection';
import 'package:rxdart/rxdart.dart';


import '../core/bloc.dart';
import '../models/movie_list_model.dart';

import '../resources/movie_fav_service.dart';

class FavoriteBloc implements BlocBase {

  // List of all
  final Set<MovieItemModel> _favorites = Set<MovieItemModel>();
  final movieFavService = MovieFavService();

  // Add
  BehaviorSubject<MovieItemModel> _favoriteAddController = new BehaviorSubject<MovieItemModel>();
  Sink<MovieItemModel> get inAddFavorite => _favoriteAddController.sink;
  // Remove
  BehaviorSubject<MovieItemModel> _favoriteRemoveController = new BehaviorSubject<MovieItemModel>();
  Sink<MovieItemModel> get inRemoveFavorite => _favoriteRemoveController.sink;
  // Total
  BehaviorSubject<int> _favoriteTotalController = new BehaviorSubject<int>(seedValue: 0);
  Sink<int> get _inTotalFavorites => _favoriteTotalController.sink;
  Stream<int> get outTotalFavorites => _favoriteTotalController.stream;
  // Get all
  BehaviorSubject<List<MovieItemModel>> _favoritesController = new BehaviorSubject<List<MovieItemModel>>(seedValue: []);
  Sink<List<MovieItemModel>> get _inFavorites =>_favoritesController.sink;
  Stream<List<MovieItemModel>> get outFavorites =>_favoritesController.stream;

  FavoriteBloc(){
    _favoriteAddController.listen(_handleAddFavorite);
    _favoriteRemoveController.listen(_handleRemoveFavorite);
  }

  void dispose(){
    _favoriteAddController.close();
    _favoriteRemoveController.close();
    _favoriteTotalController.close();
    _favoritesController.close();
    // _isFavoriteController.close();
  }

  // ############# HANDLING  #####################

  void _handleAddFavorite(MovieItemModel movie){
    _favorites.add(movie);
    movieFavService.addFavorite(movie);
    _notify();
  }

  void _handleRemoveFavorite(MovieItemModel movie){
    _favorites.removeWhere((MovieItemModel m) => m.id == movie.id);
    _notify();
  }

  void _notify(){
    _inTotalFavorites.add(_favorites.length);
    _inFavorites.add(UnmodifiableListView(_favorites));
  }
}