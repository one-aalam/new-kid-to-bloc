import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import '../models/movie_list_model.dart';
import '../core/bloc.dart';
import '../blocs/movies_detail_bloc.dart';
import '../blocs/favorites_bloc.dart';

import '../widgets/Separator.dart';
import '../widgets/GenreChip.dart';
import '../widgets/MovieVideo.dart';

// video thumb: https://img.youtube.com/vi/k3kzqVliF48/mqdefault.jpg, hqdefault.png, default.png (0.jpg)
// video trailer

class MovieDetailScreen extends StatelessWidget {
  MovieDetailScreen({
    Key key,
    @required this.movie,
    this.bloc,
  }): super(key: key);
  final MovieItemModel movie;
  final FavoriteBloc bloc;

  @override
  Widget build(BuildContext context) {
    // appBloc = BlocProvider.of<MoviesAppBloc>(context);
    return Center(
        child: Scaffold(
          appBar: AppBar(title: Text(movie.title)),
          body: Container(
            constraints: BoxConstraints.expand(),
            color: Color.fromRGBO(58, 66, 86, 1.0),
            child: Stack(
              children: <Widget>[
                _background(movie.backdropPath),
                _gradient(),
                _overview(movie, context)
              ]
            )
        ))
      );
  }

  Widget _background(String image) {
    return  Container(
            child: Image.network(
              'https://image.tmdb.org/t/p/w185$image',
              fit: BoxFit.cover,
              height: 300.0,
            ),
            constraints: new BoxConstraints.expand(height: 300.0),
          );
  }


  Widget _meta(MovieItemModel movie) {
    return Container(
      margin: new EdgeInsets.symmetric(
         vertical: 16.0
      ),
      alignment: FractionalOffset.centerLeft,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.network(
                  'https://image.tmdb.org/t/p/w185${movie.posterPath}',
                  fit: BoxFit.cover,
                  height: 240.0,
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
          ),
          SizedBox(
            width: 12.0
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    Icons.star
                  ),
                  Text(
                    '${movie.voteAverage}',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 32.0,
                    ),
                  ),
                  Text(
                    '/10',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 32.0,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              Text(
                'Release Date: ${movie.releaseDate}',
                style: TextStyle(
                  fontSize: 14.0
                ),
              )
            ]
          ),
        ]
      )
    );
  }

  Widget _overview(MovieItemModel movie, BuildContext context) {
    final _overviewTitle = "Overview".toUpperCase();
    final MoviesDetailBloc blocMovieDetail = BlocProvider.of<MoviesDetailBloc>(context);
    final _width = MediaQuery.of(context).size.width;
    blocMovieDetail.fetchMovie(movie.id);
    return ListView(
      padding: new EdgeInsets.fromLTRB(0.0, 72.0, 0.0, 32.0),
      children: <Widget>[
        Container(
          padding: new EdgeInsets.symmetric(horizontal: 32.0),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _meta(movie),
              Text(
                movie.title,
                style: TextStyle(
                  color: Colors.amber,
                  fontWeight: FontWeight.w800,
                  fontSize: 32.0,
                ),
                maxLines: 2,
                overflow: TextOverflow.fade,
                ),
              SizedBox(height: 20.0,),
              StreamBuilder(
                stream: blocMovieDetail.getMovieExt,
                builder: (BuildContext context, AsyncSnapshot<MovieItemModel> snapshot) {
                  if(snapshot.hasData) {
                    bool hasTrailers = snapshot.data.trailers.length > 0 ? true : false;
                    bool hasMoreThanOneTrailer = snapshot.data.trailers.length > 1 ? true : false;
                    return Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Wrap(
                                spacing: 8.0,
                                runSpacing: 4.0,
                                children: snapshot.data.genres.map((genre) => GenreChip(genre.text)).toList()
                              ),
                              SizedBox(height: 15.0,),
                              // Text('will play for ${snapshot.data.runtime} mins', style: TextStyle(fontStyle: FontStyle.italic),),
                              Text(
                              hasMoreThanOneTrailer ? 'TRAILERS(${snapshot.data.trailers.length})' : 'TRAILER',
                              style: TextStyle(

                                fontWeight: FontWeight.w600,
                                fontSize: 20.0,
                              )),
                              Separator(),
                              hasTrailers ?
                                Container(
                                margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                                height: 120.0,
                                width: _width,
                                child: ListView.builder(
                                  itemCount: snapshot.data.trailers.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (BuildContext context, int index) {
                                    return GestureDetector(
                                      child: Container(
                                        margin: index == 0 ? EdgeInsets.only(left: 0.0) : EdgeInsets.only(left: 10.0),
                                        child: MovieVideo("https://img.youtube.com/vi/${snapshot.data.trailers[index].key}/mqdefault.jpg")
                                      ),
                                      onTap: () {
                                        Chewie(
                                          VideoPlayerController.network(
                                            'https://flutter.github.io/assets-for-api-docs/videos/butterfly.mp4'
                                          ),
                                          aspectRatio: 3 / 2,
                                          autoPlay: true,
                                          looping: true,
                                        );

                                        print('clicked');
                                        // youtube.playYoutubeVideoByUrl(
                                        //   apiKey: "<API_KEY>",
                                        //   videoUrl: "<Youtube Video URL>",
                                        //   autoPlay: true, //default falase
                                        //   fullScreen: true //default false
                                        // );
                                        // flutterWebviewPlugin.launch('https://www.youtube.com/watch?v=k3kzqVliF48', hidden: true);
                                      },
                                    );
                                  }
                              ),) : Text('No videos found!')
                              ,
                              SizedBox(height: 15.0,)
                            ]
                          ),
                    );
                  }
                  return LinearProgressIndicator();
                },
              ),
              StreamBuilder(
                stream: bloc.outFavorites,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if(snapshot.hasData && snapshot.data.map((MovieItemModel i) => i.id).toList().contains(movie.id)) {
                    return RaisedButton.icon(
                      color: Colors.amber,
                      elevation: 4.0,
                      splashColor: Colors.pink,
                      icon: Icon(Icons.favorite),
                      label: Text('Remove from favorites!'),
                      onPressed: () {
                        bloc.inRemoveFavorite.add(movie);
                        Scaffold.of(context).showSnackBar(new SnackBar(
                          content: Text("${movie.title} removed from your favorites",style: TextStyle(color: Colors.red)),
                        ));
                      },
                    );
                  }
                  return RaisedButton.icon(
                    color: Colors.pink,
                    elevation: 4.0,
                    splashColor: Colors.amber,
                    icon: Icon(Icons.favorite_border),
                    label: Text('Mark As Favorite!'),
                    onPressed: () {
                      bloc.inAddFavorite.add(movie);
                      Scaffold.of(context).showSnackBar(new SnackBar(
                        content: Row(children: <Widget>[
                          Text(movie.title, style: TextStyle(fontWeight: FontWeight.w800, color: Colors.amber),),
                          Text(" added to your favorites",)
                        ],),
                      ));
                    },
                  );
            }
          ),
          SizedBox(height: 20.0),
              Text(
                _overviewTitle,
                style: TextStyle(

                  fontWeight: FontWeight.w600,
                  fontSize: 20.0,
                )),
              GestureDetector(child:Separator(), onTap: () {  }),
              Text(
                movie.overview,
              )
              ],
            ),
          ),
      ]
    );
  }

  Container _gradient() {
    return Container(
      margin: EdgeInsets.only(top: 190.0),
      height: 110.0,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            Color(0x3A4256),
            Color.fromRGBO(58, 66, 86, 1.0),
          ],
          stops: [0.0, 0.9],
          begin: FractionalOffset(0.0, 0.0),
          end: FractionalOffset(0.0, 1.0),
        ),
      ),
    );
  }
}