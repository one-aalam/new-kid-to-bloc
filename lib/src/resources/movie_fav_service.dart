import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/movie_list_model.dart';

class MovieFavService {
  static const String baseUrl = 'api.themoviedb.org';
  final String fbBaseUrl = 'https://muvyluv.firebaseio.com/';

  Future addFavorite(MovieItemModel m) async {
    final Map<String, dynamic> movie = {
      'id': m.id,
      'title': m.title,
      'posterPath': m.posterPath
    };
    final uri = fbBaseUrl + 'favorites.json';
    print('hitting:' + uri);
    return http.post(uri, body: json.encode(movie)).then((response) => print(json.decode(response.body)));
  }
}