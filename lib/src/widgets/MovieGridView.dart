import 'package:flutter/material.dart';
import '../models/movie_list_model.dart';


class HorizMovieListWidget extends StatelessWidget {
  HorizMovieListWidget(this.movies, this.onItemTap);
  final List<MovieItemModel> movies;
  final Function onItemTap;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: movies.length,
        gridDelegate:
            new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            child: Image.network(
              'https://image.tmdb.org/t/p/w185${movies[index].posterPath}',
              fit: BoxFit.cover,
            ),
            onTap: () {
              onItemTap(movies[index], context);
            },
          );
      }
    );
  }
}