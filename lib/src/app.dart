import 'package:flutter/material.dart';
import 'screens/movie_list_screen.dart';
import 'screens/movie_fav_list_screen.dart';
import 'screens/movie_search_screen.dart';
import 'screens/user_profile_screen.dart';
import './core/bloc.dart';
import './blocs/movies_app_bloc.dart';
import './blocs/favorites_bloc.dart';

// Thanks you, https://www.didierboelens.com for guiding my ways!

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final FavoriteBloc favoriteBloc = FavoriteBloc();
    return MaterialApp(
      title: 'Movy',
      theme: ThemeData.dark(),
      home: BlocProvider<MoviesAppBloc>(
        bloc: MoviesAppBloc(),
        child: BlocProvider<FavoriteBloc>(
          bloc: favoriteBloc,
          child: MovieListScreen()
        )
      ),
      routes: <String, WidgetBuilder>{
        '/favorites': (_) => BlocProvider<FavoriteBloc>(
            bloc: favoriteBloc,
            child: MovieFavoriteListScreen()
          ),
        '/search': (_) => MovieSearchScreen(),
        '/me': (_) => UserProfileScreen()
      },
    );
  }
}
