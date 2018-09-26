class MovieListModel {
  int _page;
  int _totalResults;
  int _totalPages;
  List<_MovieItemModel> _results = [];

  MovieListModel.fromJSON(Map<String, dynamic> parsedJson) {
    print(parsedJson['results'].length);
    _page = parsedJson['page'];
    _totalResults = parsedJson['total_results'];
    _totalPages = parsedJson['total_pages'];
    List<_MovieItemModel> temp = [];
    for (int i = 0; i < parsedJson['results'].length; i++) {
      _MovieItemModel result = _MovieItemModel(parsedJson['results'][i]);
      temp.add(result);
    }
    _results = temp;
  }

  List<_MovieItemModel> get results => _results;
  int get totalPages => _totalPages;
  int get totalResults => _totalResults;
  int get page => _page;
}

class _MovieItemModel {
    int _voteCount;
    int _id;
    bool _video;
    // double _voteAverage;
    String _title;
    double _popularity;
    String _posterPath;
    String _originalLanguage;
    String _originalTitle;
    List<int>  _genreIds = [];
    String _backdropPath;
    bool _adult;
    String _overview;
    // String _releaseDate;

    _MovieItemModel(parsedResp) {
      _voteCount = parsedResp['vote_count'];
      _id = parsedResp['id'];
      _video = parsedResp['video'];
      // _voteAverage = parsedResp['vote_average'];
      _title = parsedResp['title'];
      _popularity = parsedResp['popularity'];
      _posterPath = parsedResp['poster_path'];
      _originalLanguage = parsedResp['original_language'];
      _originalTitle = parsedResp['original_title'];
      _backdropPath = parsedResp['backdrop_path'];
      _adult = parsedResp['adult'];
      _overview = parsedResp['overview'];
      // _releaseDate = parsedResp['release_date'];
      for(int i = 0; i < parsedResp['genre_ids'].length; i++ ) {
        _genreIds.add(parsedResp['genre_ids'][i]);
      }

    }

    int get voteCount => _voteCount;
    int get id => _id;
    bool get video => _video;
    // double get voteAverage => _voteAverage;
    String get title => _title;
    double get popularity => _popularity;
    String get posterPath => _posterPath;
    String get originalLanguage => _originalLanguage;
    String get originalTitle =>_originalTitle;
    List<int> get genreIds => _genreIds;
    String get backdropPath => _backdropPath;
    bool get adult => _adult;
    String get overview => _overview;
    // String releaseDate => _releaseDate;

}