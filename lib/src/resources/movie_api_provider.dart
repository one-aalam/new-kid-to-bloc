import 'dart:async';
import 'package:http/http.dart' show Client;
import 'dart:convert';
import '../models/movie_list_model.dart';
import '../models/movie_genre_list.dart';

class MovieService {
  static const String TMDB_API_KEY = ''; // Put in the TMDB API key here...
  static const String baseUrl = 'api.themoviedb.org';
  final String imageBaseUrl = 'http://image.tmdb.org/t/p/w185/';
  Client client = new Client();

  Future<MovieListModel> getMovies() async {
    final response = await _get('/3/movie/popular');
    if (response.statusCode == 200) {
      return MovieListModel.fromJSON(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }


  Future<MovieListModel> getMoviesNowPlaying() async {
    final response = await _get('/3/movie/now_playing');
    if (response.statusCode == 200) {
      return MovieListModel.fromJSON(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<MovieListModel> getMoviesLatest() async {
    final response = await _get('/3/movie/now_playing');
    if (response.statusCode == 200) {
      return MovieListModel.fromJSON(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<MovieListModel> getMoviesTopRated() async {
    final response = await _get('/3/movie/top_rated');
    if (response.statusCode == 200) {
      return MovieListModel.fromJSON(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<MovieListModel> getMoviesUpcoming() async {
    final response = await _get('/3/movie/upcoming');
    if (response.statusCode == 200) {
      return MovieListModel.fromJSON(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<MovieItemModel> getMovie(int movieId) async {
    final response = await _get('/3/movie/$movieId', {"append_to_response": "videos"}); // credits, reviews
    if (response.statusCode == 200) {
      return MovieItemModel(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<TvListModel> getTvs() async {
    final response = await _get('/3/tv/popular');
    if (response.statusCode == 200) {
      return TvListModel.fromJSON(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<MovieGenreListModel> getGenres({String type: "movie"}) async {
    final response = await _get('3/genre/$type/list');
    MovieGenreListModel list = MovieGenreListModel.fromJSON(json.decode(response.body));
    return list;
  }

  Future _get(String relativeUri, [Map<String, String> relativeUriQueryParams]) async {
    Map<String, String> queryParams = {};
    if(relativeUriQueryParams != null) {
      queryParams..addAll(relativeUriQueryParams);
    }
    var uri = Uri.http(
      baseUrl,
      relativeUri,
      <String, String>{
        'api_key': TMDB_API_KEY,
        'language': 'en-US',
      }..addAll(queryParams),
    );
    return await client.get(uri);
  }

}