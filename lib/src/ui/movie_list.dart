import 'package:flutter/material.dart';

import '../models/movie_list_model.dart';
import '../blocs/movies_bloc.dart';


class MovieList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MovieListState();
  }
}


class MovieListState extends State<MovieList> {
  @override
  void initState() {
    super.initState();
    bloc.fetchAllMovies();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext  context) {
    bloc.fetchAllMovies();
    return Scaffold(appBar: AppBar(
      title: Text('Popular Movies'),
    ), body: StreamBuilder<MovieListModel>(
      stream: bloc.getMovies,
      builder: (context, AsyncSnapshot<MovieListModel> snapshot) {
        if (snapshot.hasData) {
            return buildList(snapshot);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
      },
    ));
  }


  Widget buildList(AsyncSnapshot<MovieListModel> snapshot) {
    return GridView.builder(
        itemCount: snapshot.data.results.length,
        gridDelegate:
            new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return Image.network(
            'https://image.tmdb.org/t/p/w185${snapshot.data.results[index].posterPath}',
            fit: BoxFit.cover,
          );
        });
  }
}