
import './movie_genre.dart';
class MovieListModel {
  int _page;
  int _totalResults;
  int _totalPages;
  List<MovieItemModel> _results = [];

  MovieListModel.fromJSON(Map<String, dynamic> json) {
    _page = json['page'];
    _totalResults = json['total_results'];
    _totalPages = json['total_pages'];
    List<MovieItemModel> temp = [];
    for (int i = 0; i < json['results'].length; i++) {
      MovieItemModel result = MovieItemModel(json['results'][i]);
      temp.add(result);
    }
    _results = temp;
  }

  List<MovieItemModel> get results => _results;
  int get totalPages => _totalPages;
  int get totalResults => _totalResults;
  int get page => _page;
}

class TvListModel {
  int _page;
  int _totalResults;
  int _totalPages;
  List<TvItemModel> _results = [];

  TvListModel.fromJSON(Map<String, dynamic> json) {
    print(json['results'].length);
    _page = json['page'];
    _totalResults = json['total_results'];
    _totalPages = json['total_pages'];
    List<TvItemModel> temp = [];
    for (int i = 0; i < json['results'].length; i++) {
      TvItemModel result = TvItemModel(json['results'][i]);
      temp.add(result);
    }
    _results = temp;
  }

  List<TvItemModel> get results => _results;
  int get totalPages => _totalPages;
  int get totalResults => _totalResults;
  int get page => _page;
}

class MovieItemModel {
    int _voteCount;
    int _id;
    bool _video;
    String _voteAverage;
    String _title;
    double _popularity;
    String _posterPath;
    String _originalLanguage;
    String _originalTitle;
    List<int>  _genreIds = [];
    String _backdropPath;
    bool _adult;
    String _overview;
    String _releaseDate;
    // Extended
    String _runtime;
    List<MovieGenreModel>  _genres = [];
    List<MovieTrailerModel> _trailers = [];

    MovieItemModel(Map<String, dynamic> resp) {
      _voteCount = resp['vote_count'];
      _id = resp['id'];
      _video = resp['video'];
      _voteAverage = resp['vote_average'].toString();
      _title = resp['title'];
      _popularity = resp['popularity'];
      _posterPath = resp['poster_path'];
      _originalLanguage = resp['original_language'];
      _originalTitle = resp['original_title'];
      _backdropPath = resp['backdrop_path'];
      _adult = resp['adult'];
      _overview = resp['overview'];
      if(resp.containsKey('runtime')) {
        _runtime = resp['runtime'].toString();
      } else {
        _runtime = '';
      }
      if(resp.containsKey('genres')) {
        _genres = (resp['genres'] as List<dynamic>)
                .map(
                  (item) => MovieGenreModel.fromJSON(item)
                ).toList();
        _genres.forEach((f) => _genreIds.add(f.genre));
      } else {
        for(int i = 0; i < resp['genre_ids'].length; i++ ) {
          _genreIds.add(resp['genre_ids'][i]);
        }
        _genres = []; // empty for basic call
      }
      if(resp.containsKey('videos') && resp['videos'] != null) {
        //var trailers = resp['videos'] as List<dynamic>
        _trailers = (resp['videos']['results'] as List<dynamic>)
                .map(
                  (item) => MovieTrailerModel.fromJSON(item)
                ).toList();
      } else {
        _trailers = [];
      }
      _releaseDate = resp['release_date'].toString();

    }

    int get voteCount => _voteCount;
    int get id => _id;
    bool get video => _video;
    String get voteAverage => _voteAverage;
    String get title => _title;
    double get popularity => _popularity;
    String get posterPath => _posterPath;
    String get originalLanguage => _originalLanguage;
    String get originalTitle =>_originalTitle;
    List<int> get genreIds => _genreIds;
    String get backdropPath => _backdropPath;
    bool get adult => _adult;
    String get overview => _overview;
    String get releaseDate => _releaseDate;
    // Extended details
    String get runtime => _runtime;
    List<MovieGenreModel> get genres => _genres;
    List<MovieTrailerModel> get trailers => _trailers;

}

class TvItemModel {
    int _voteCount;
    int _id;
    bool _video;
    String _voteAverage;
    String _title;
    double _popularity;
    String _posterPath;
    String _originalLanguage;
    String _originalName;
    List<int>  _genreIds = [];
    String _backdropPath;
    String _overview;
    String _firstAirDate;

    TvItemModel(resp) {
      _voteCount = resp['vote_count'];
      _id = resp['id'];
      _video = resp['video'];
      _voteAverage = resp['vote_average'].toString();
      _title = resp['name'];
      _popularity = resp['popularity'];
      _posterPath = resp['poster_path'];
      _originalLanguage = resp['original_language'];
      _originalName = resp['original_name'];
      _backdropPath = resp['backdrop_path'];
      _overview = resp['overview'];
      _firstAirDate = resp['first_air_date'].toString();
      for(int i = 0; i < resp['genre_ids'].length; i++ ) {
        _genreIds.add(resp['genre_ids'][i]);
      }

    }

    int get voteCount => _voteCount;
    int get id => _id;
    bool get video => _video;
    String get voteAverage => _voteAverage;
    String get title => _title;
    double get popularity => _popularity;
    String get posterPath => _posterPath;
    String get originalLanguage => _originalLanguage;
    String get originalName =>_originalName;
    List<int> get genreIds => _genreIds;
    String get backdropPath => _backdropPath;
    String get overview => _overview;
    String get firstAirDate => _firstAirDate;

}