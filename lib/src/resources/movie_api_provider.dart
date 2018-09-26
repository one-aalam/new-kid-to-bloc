import 'dart:async';
import 'package:http/http.dart' show Client;
import 'dart:convert';
import '../models/movie_list_model.dart';

class MovieService {
  Client client = new Client();
  final _apiKey = '802b2c4b88ea1183e50e6b285a27696e';

  Future<MovieListModel> getMovies() async {
    print("entered in service");
    final response = await client
        .get("http://api.themoviedb.org/3/movie/popular?api_key=$_apiKey");
    print(response.body.toString());
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      return MovieListModel.fromJSON(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

}