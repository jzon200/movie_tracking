import 'package:flutter/cupertino.dart';
import 'package:movie_tracking/data/repository.dart';
import 'package:movie_tracking/models/movie.dart';

class MoviesRepository extends Repository with ChangeNotifier {
  final List<Movie> _currentMovies = [];

  @override
  void close() {
    // TODO: implement close
  }

  @override
  Future<void> deleteMovie(Movie movie) async {
    // TODO: implement deleteMovie
  }

  @override
  Movie findMovieById(String id) {
    // TODO: implement findMovieById
    throw UnimplementedError();
  }

  @override
  List<Movie> findMovies() {
    return _currentMovies;
  }

  @override
  Future init() {
    // TODO: implement init
    throw UnimplementedError();
  }

  @override
  int insertMovie(Movie movie) {
    // TODO: implement insertMovie
    throw UnimplementedError();
  }

  List<Movie> insertMovies(List<Movie> movies) {
    _currentMovies.addAll(movies);
    notifyListeners();
    return movies;
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
