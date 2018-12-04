import 'package:flutter/material.dart';
// Models
import '../models/movie_list_model.dart';
import '../models/movie_genre_list.dart';
// BLoCs
import '../core/bloc.dart';
import '../blocs/movies_app_bloc.dart';
import '../blocs/favorites_bloc.dart';
import '../blocs/movies_bloc.dart';
import '../blocs/movies_detail_bloc.dart';
// Screens (Programmatic navigation)
import './movie_detail_screen.dart';
// UI Components
import '../core/blinking_toast.dart';
import '../widgets/AppBar.dart';
import '../widgets/SectionHeading.dart';
import '../widgets/MoviePoster.dart';
import '../widgets/RatingChip.dart';
import '../widgets/GenreChip.dart';



class MovieListScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKeyMovieList = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Center(
          child: Scaffold(
            key: _scaffoldKeyMovieList,
            drawer: Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerHeader(
                    child: Container(
                      child: CircleAvatar(
                        backgroundImage: NetworkImage('https://picsum.photos/100'),
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('Preferences'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.exit_to_app),
                    title: Text('Sign Out'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              )
            ),
            // App
            appBar: GradientAppBar('Movy'),
            // Subscribes to...
            body: BlocProvider<MoviesBloc>(
                  bloc: MoviesBloc(),
                  child: MovieListWidget(),
            ),
            backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
          // Bottom Navigation Bar
            bottomNavigationBar: Container(
              height: 55.0,
              child: BottomAppBar(
                color: Color.fromRGBO(58, 66, 86, 1.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.home, color: Colors.white),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(Icons.search, color: Colors.white),
                      onPressed: () {
                        Navigator.pushNamed(context, "/search");
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.favorite, color: Colors.white),
                      onPressed: () {
                        Navigator.pushNamed(context, "/favorites");
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.account_box, color: Colors.white),
                      onPressed: () {
                        Navigator.pushNamed(context, "/me");
                      },
                    )
                  ],
                ),
              ),
            )
        )
    );
  }
}

class MovieListWidget extends StatelessWidget {
  MovieGenreListModel genres;
  @override
  Widget build(BuildContext context) {

    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    final MoviesAppBloc blocMoviesApp = BlocProvider.of<MoviesAppBloc>(context);
    final MoviesBloc blocMovies = BlocProvider.of<MoviesBloc>(context);
    blocMovies.fetchAllMovies();

    blocMoviesApp.getGenres.listen((data) => genres = data);
    blocMoviesApp.fetchAllGenres();
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SectionHeading(icon: Icons.new_releases, text: 'Newest',),
        Container(
          margin: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
          height: 210.0,
          width: _width,
          child: StreamBuilder<MovieListModel>(
            stream: blocMovies.getMovies,
            builder: (context, AsyncSnapshot<MovieListModel> snapshot) {
                if (snapshot.hasData) {
                  return _buildMovieListHorizView(snapshot);
                } else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                return Center(child: CircularProgressIndicator());
            },
          ),
        ),
        SectionHeading(icon: Icons.trending_up, text: 'Popular',),
        Expanded(
          child: Container(
          margin: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
          child: StreamBuilder<MovieListModel>(
            stream: blocMovies.getMovies,
            builder: (context, AsyncSnapshot<MovieListModel> snapshot) {
                if (snapshot.hasData) {
                  return _buildMovieListVerticalView(snapshot);
                } else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                return Center(child: CircularProgressIndicator());
            },
          ),
          ),
        ),
      ]
    );
  }

  Widget buildGenreView(AsyncSnapshot<MovieGenreListModel> snapshot) {
    return ListView.builder(
      itemCount: snapshot.data.genres.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        return ActionChip(
          avatar: null,
          label: new Text(snapshot.data.genres[index].text),
          onPressed: () {
            // print(snapshot.data.genres[index].genre);
          }
        );
      }
    );
  }

  Widget _buildMovieListHorizView(AsyncSnapshot<MovieListModel> snapshot) {
    return ListView.builder(
      itemCount: snapshot.data.results.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        return Container(
            margin: index == 0 ? EdgeInsets.only(left: 0.0) : EdgeInsets.only(left: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  child: MoviePoster('https://image.tmdb.org/t/p/w185${snapshot.data.results[index].posterPath}'),
                  onTap: () {
                    _navigateToMovieDetail(snapshot.data.results[index], context);
                  },
                ),
                SizedBox(height: 5.0,),
                SizedBox(
                  width: 120.0,
                  height: 20.0,
                  child:
                  Text(
                  snapshot.data.results[index].title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14.0,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.fade,
                )),
              ]
            )
        );
      }
    );
  }

  Widget _buildMovieListVerticalView(AsyncSnapshot<MovieListModel> snapshot) {
    return ListView.builder(
        itemCount: snapshot.data.results.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: EdgeInsets.only(bottom: 15.0),
            height: 180.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  child: GestureDetector(
                    child: MoviePoster('https://image.tmdb.org/t/p/w185${snapshot.data.results[index].posterPath}'),
                    onTap: () {
                      _navigateToMovieDetail(snapshot.data.results[index], context);
                    },
                  )
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left:10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Flexible(
                          child: Text(
                            snapshot.data.results[index].title,
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 20.0,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.fade,
                          ),
                        ),
                        SizedBox(
                          height: 10.0
                        ),
                        Row(
                          children: [
                            RatingChip(snapshot.data.results[index].voteAverage),
                            SizedBox(width: 4.0),
                            Text(
                              '(${snapshot.data.results[index].voteCount.toString()} ratings)',
                              style: TextStyle(color: Colors.grey)
                            ),
                          ]
                        ),
                        SizedBox(
                          height: 10.0
                        ),

                        Container(
                          child: Wrap(
                            spacing: 8.0,
                            runSpacing: 4.0,
                            children: snapshot.data.results[index].genreIds.map((genreId) => GenreChip(genres.findById(genreId).text)).toList()
                          )
                        ),

                        SizedBox(
                          height: 20.0
                        ),

                        GestureDetector(
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Row(
                              children: [
                                Icon(Icons.favorite),
                                Text('add to favs')
                              ]
                            ),
                          ),
                          onTap: () {
                            BlinkingToast toast = new BlinkingToast();

                            toast.show(
                                context: context,
                                externalBuilder: (BuildContext context){
                                    return new Icon(Icons.warning, color: Colors.purple);
                                },
                                duration: new Duration(seconds: 5),
                                position: new Offset(50.0, 50.0),
                            );
                          },
                        )
                      ]
                    )
                  )
                )
              ]
            )
          );
      }
    );
  }

  _navigateToMovieDetail(movie, context) {
     final FavoriteBloc blocMovieFavorite = BlocProvider.of<FavoriteBloc>(context);
    // Simple Nav!
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context) => BlocProvider<MoviesDetailBloc>(
            bloc: MoviesDetailBloc(),
            child: MovieDetailScreen(movie: movie, bloc: blocMovieFavorite)
        )
      )
    );
  }
}


