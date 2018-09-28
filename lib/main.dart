import 'package:flutter/material.dart';
import 'src/core/bloc.dart';
import 'src/blocs/counter_bloc.dart';
// import 'src/ui/movie_list.dart';
import 'src/screens/counter_screen.dart';

void main() => runApp(new MyApp());


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'New Kid on the BLOC',
      theme: ThemeData.dark(),
      home: BlocProvider<CounterBloc>(
        bloc: CounterBloc(),
        child: CounterScreen(),
      )
    );
  }
}