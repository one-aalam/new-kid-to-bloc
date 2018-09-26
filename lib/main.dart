import 'package:flutter/material.dart';
import 'src/ui/movie_list.dart';

void main() => runApp(new MyApp());


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'New Kid on the BLOC',
      theme: ThemeData.dark(),
      home: Scaffold(
        body: MovieList()
      )
    );
  }
}