import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:movie_tracking/data/repository.dart';
import 'package:movie_tracking/models/movie.dart';

import 'hive_db.dart';

class TrendingRepository extends Repository with ChangeNotifier {
  final box = Hive.box('trending_movies');

  @override
  List<Movie> addMovies(List<Movie> movies) {
    box
      ..clear()
      ..addAll(movies.map((movie) => HiveMovie.toHive(movie)).toList());
    notifyListeners();
    return box.values.map((movie) => Movie.fromHive(movie)).toList();
  }

  @override
  Future init() async {
    await Hive.openBox('trending_movies');
    return Future.value();
  }

  @override
  void close() {
    box.close();
  }

  @override
  void addMovie(Movie movie) {
    // TODO: implement addMovie
  }

  @override
  void deleteMovie(Movie movie) {
    // TODO: implement deleteMovie
  }

  @override
  List<Movie> getMovies() {
    // TODO: implement getMovies
    throw UnimplementedError();
  }

  @override
  void updateMovie(Movie movie) {
    // TODO: implement updateMovie
  }
}
