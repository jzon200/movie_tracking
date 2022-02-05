import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movie_tracking/data/hive/hive_db.dart';
import 'package:movie_tracking/data/repository.dart';
import 'package:movie_tracking/models/movie.dart';

class HiveRepository extends Repository {
  @override
  Future<void> addMovie(Movie movie) async {
    await Hive.box('movies').add(movie);
  }

  @override
  Future<void> deleteMovie(Movie movie) async {
    await Hive.box('movies').delete(movie.id);
  }

  @override
  Future<List<Movie>> getMovies() async {
    final box = Hive.box<HiveMovie>('movies');
    return box.values
        .map((e) => Movie(
              id: e.id,
              title: e.title,
              genres: e.genres,
              imageUrl: e.imageUrl,
              rating: e.rating,
              director: e.director,
              duration: e.duration,
              overview: e.overview,
              year: e.year,
              // isWatchlist: e.isWatchlist,
            ))
        .toList();
  }

  @override
  Future<void> updateMovie(Movie movie) async {
    await Hive.box('movies').put(movie.id, movie);
  }

  @override
  Future init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(HiveMovieAdapter());
    await Hive.openBox<HiveMovie>('movies');
  }

  @override
  void close() {
    Hive.close();
  }
}
