import 'package:flutter/material.dart';
import '../models/movie_list_model.dart';


class HorizMovieListWidget extends StatelessWidget {
  HorizMovieListWidget(this.movies);
  final List<MovieItemModel> movies;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
      EdgeInsets padding = index == 0 ?
        const EdgeInsets.only(left: 20.0, right: 10.0, top: 4.0, bottom: 30.0):
        const EdgeInsets.only(left: 10.0, right: 10.0, top: 4.0, bottom: 30.0);

      return new Padding(
        padding: padding,
        child: new InkWell(
          onTap: () {

          },
          child: Container(
            child: Text('Titme'),
            width: 200.0
          ),
        ),
      );
    },
    scrollDirection: Axis.horizontal,
    itemCount: movies.length
    );
  }
}