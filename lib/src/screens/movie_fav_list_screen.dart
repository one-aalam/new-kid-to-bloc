import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import '../core/bloc.dart';
import '../blocs/favorites_bloc.dart';
import '../models/movie_list_model.dart';
// Screens (Programmatic navigation)
import './movie_detail_screen.dart';
import '../widgets/SectionHeading.dart';
import '../widgets/MoviePoster.dart';

class MovieFavoriteListScreen extends StatefulWidget {
  @override
  _MovieFavoriteListScreenState createState() => _MovieFavoriteListScreenState();
}

class _MovieFavoriteListScreenState extends State<MovieFavoriteListScreen> with TickerProviderStateMixin {

  Animation<double> cardAnimation;
  AnimationController cardAnimController;

  @override
  initState() {
    super.initState();

    cardAnimController = AnimationController(
      duration: Duration(
        seconds: 2,
      ),
      vsync: this
    );

    // Range of values we want to animate over
    cardAnimation = Tween(
      begin: 0.0,
      end: 100.0
    ).animate(
      CurvedAnimation(
        parent: cardAnimController,
        curve: Curves.easeIn
      )
    );

  }

  @override
  Widget build(BuildContext context) {
    final FavoriteBloc blocMovieFavorite = BlocProvider.of<FavoriteBloc>(context);
    return Scaffold(
        appBar: AppBar(title: Text('Animation')),
        body: Center(
          child: Column(
            children: [
              SectionHeading(icon: Icons.favorite, text: 'Favorites',),
              SizedBox(height: 10.0,),

                  Expanded(
                    child:               Container(
                margin: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0), child: StreamBuilder(
                      stream: blocMovieFavorite.outFavorites,
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if(snapshot.hasData) {
                          return buildGridView(snapshot);
                        }
                        return CircularProgressIndicator();

                      }
                    )
                  ),
                  ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {

          },
        ));
  }

  Widget buildGridView(AsyncSnapshot<List<MovieItemModel>> snapshot) {
    return GridView.builder(
        itemCount: snapshot.data.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 0.2,
          childAspectRatio: 0.52,
        ),
        // shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 200.0,
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  child: MoviePoster('https://image.tmdb.org/t/p/w185${snapshot.data[index].posterPath}'),
                  onTap: () {
                    _navigateToMovieDetail(snapshot.data[index], context);
                  },
                ),
                SizedBox(height: 5.0,),
                SizedBox(
                  width: 120.0,
                  height: 20.0,
                  child:
                  Text(
                  snapshot.data[index].title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14.0,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                )),
              ]
            ));
      }
    );
  }

  _navigateToMovieDetail(movie, context) {
     final FavoriteBloc blocMovieFavorite = BlocProvider.of<FavoriteBloc>(context);
    // Simple Nav!
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context) => MovieDetailScreen(movie: movie, bloc: blocMovieFavorite)
      )
    );
  }
}
