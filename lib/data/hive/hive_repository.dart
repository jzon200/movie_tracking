import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movie_tracking/data/hive/hive_db.dart';
import 'package:movie_tracking/data/repository.dart';
import 'package:movie_tracking/models/movie.dart';

class HiveRepository extends Repository with ChangeNotifier {
  // final _trendingMoviesBox = Hive.box<HiveMovie>('trending_movies');
  // final _topMoviesBox = Hive.box<HiveMovie>('top_movies');
  // final _watchlistMoviesBox = Hive.box<HiveMovie>('watchlist_movies');

  List<HiveMovie> _trendingMovies = <HiveMovie>[];
  List<HiveMovie> _topMovies = <HiveMovie>[];
  List<HiveMovie> _watchlistMovies = <HiveMovie>[];

  @override
  Future init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(HiveMovieAdapter());
    await Hive.openBox<HiveMovie>('trending_movies');
    await Hive.openBox<HiveMovie>('top_movies');
    await Hive.openBox<HiveMovie>('watchlist_movies');

    // _trendingMovies = _trendingMoviesBox.values.toList();
    // _topRatedMovies = _topRatedMoviesBox.values.toList();
    // _watchlistMovies = _watchlistMoviesBox.values.toList();
    return Future.value();
  }

  @override
  void close() {
    Hive.box<HiveMovie>('watchlist_movies').close();
  }

  @override
  void addMovie(Movie movie) {
    // _watchlistMoviesBox = Hive.box<HiveMovie>('watchlist_movies');
    Hive.box<HiveMovie>('watchlist_movies')
        .put(movie.id, HiveMovie.toHive(movie));
    notifyListeners();
  }

  @override
  void deleteMovie(Movie movie) {
    // _watchlistMoviesBox = Hive.box<HiveMovie>('watchlist_movies');
    Hive.box<HiveMovie>('watchlist_movies').delete(movie.id);
    notifyListeners();
  }

  @override
  List<Movie> getMovies() {
    // _watchlistMoviesBox = Hive.box<HiveMovie>('watchlist_movies');
    _watchlistMovies = Hive.box<HiveMovie>('watchlist_movies').values.toList();
    return _watchlistMovies.map((movie) => Movie.fromHive(movie)).toList();
  }

  @override
  void updateMovie(Movie movie) {
    // TODO: implement updateMovie
  }

  List<Movie> addMovies(List<Movie> movies) {
    final box = Hive.box<HiveMovie>('trending_movies')
      ..clear()
      ..addAll(movies.map((movie) => HiveMovie.toHive(movie)).toList());
    notifyListeners();
    return box.values.map((movie) => Movie.fromHive(movie)).toList();
  }
}
