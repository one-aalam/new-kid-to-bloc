import 'package:flutter/material.dart';

class MoviePoster extends StatelessWidget {
  MoviePoster(this.moviePoster);
  final String moviePoster;
  @override
  Widget build(BuildContext context) {
    // final _height = MediaQuery.of(context).size.height;
    return Container(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: FadeInImage(
                          image: NetworkImage(moviePoster),
                          fit: BoxFit.cover,
                          height: 180.0,
                          placeholder: AssetImage('assets/img/placeholder.jpeg'),
                        ),
                      ),
                    decoration: BoxDecoration(
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10.0,
                          offset: Offset(0.0, 10.0),
                        ),
                      ],
                    ),
    );
  }
}