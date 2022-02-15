import '../models/movie.dart';

abstract class Repository {
  void addMovie(Movie movie);

  List<Movie> addMovies(List<Movie> movies);

  void deleteMovie(Movie movie);

  List<Movie> getMovies();

  void updateMovie(Movie movie);

  Future init();

  void close();
}
