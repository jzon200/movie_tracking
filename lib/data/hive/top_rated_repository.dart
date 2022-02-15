import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import '../../models/movie.dart';
import '../repository.dart';
import 'hive_db.dart';

class TopRatedRepository extends Repository with ChangeNotifier {
  final box = Hive.box('top_movies');

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
    await Hive.openBox('top_movies');
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
