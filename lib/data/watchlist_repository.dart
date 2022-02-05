import 'package:flutter/foundation.dart';
import 'repository.dart';
import '../models/movie.dart';

class WatchlistRepository extends Repository with ChangeNotifier {
  final List<Movie> _currentMovies = <Movie>[];

  @override
  List<Movie> findMovies() {
    return _currentMovies;
  }

  @override
  Movie findMovieById(String id) {
    return _currentMovies.firstWhere((movie) => movie.id == id);
  }

  @override
  int insertMovie(Movie movie) {
    _currentMovies.add(movie);
    notifyListeners();
    return 0;
  }

  @override
  Future<void> deleteMovie(Movie movie) async {
    _currentMovies.remove(movie);
    notifyListeners();
  }

  @override
  Future init() {
    return Future.value(null);
  }

  @override
  void close() {
    // TODO: implement close
  }

  @override
  Future<void> addMovie(Movie movie) {
    // TODO: implement addMovie
    throw UnimplementedError();
  }

  @override
  Future<List<Movie>> getMovies() {
    // TODO: implement getMovies
    throw UnimplementedError();
  }

  @override
  Future<void> updateMovie(Movie movie) {
    // TODO: implement updateMovie
    throw UnimplementedError();
  }
}
