import 'package:flutter/material.dart';
import 'src/core/bloc.dart';
import 'src/blocs/signin_bloc.dart';
// import 'src/blocs/counter_bloc.dart';
// import 'src/ui/movie_list.dart';
// import 'src/screens/counter_screen.dart';
// import 'src/screens/list_screen.dart';
import 'src/screens/signin_screen.dart';

void main() => runApp(new MyApp());


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'New Kid on the BLOC',
      theme: ThemeData.dark(),
      home: Center(
        child: Scaffold(
          appBar: AppBar(title: Text('Sign In')),
          body: BlocProvider<SignInBloc>(
            bloc: SignInBloc(),
            child: SignInScreen(),
          )
        )
      ),
    );
  }
}