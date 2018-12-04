import 'package:flutter/material.dart';

class MovieVideo extends StatelessWidget {
  MovieVideo(this.videoThumb);
  final String videoThumb;
  @override
  Widget build(BuildContext context) {
    // final _height = MediaQuery.of(context).size.height;
    return Container(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.network(
                          videoThumb,
                          fit: BoxFit.cover,
                          height: 100.0,
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