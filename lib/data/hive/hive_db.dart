import 'package:hive/hive.dart';

import '../../models/movie.dart';
part 'hive_db.g.dart';

@HiveType(typeId: 0)
class HiveMovie extends HiveObject {
  @HiveField(0)
  final String? id;
  @HiveField(1)
  final String? title;
  @HiveField(2)
  final String? overview;
  @HiveField(3)
  final String? imageUrl;
  @HiveField(4)
  final String? director;
  @HiveField(5)
  final int? duration;
  @HiveField(6)
  final double? rating;
  @HiveField(7)
  final int? year;
  @HiveField(8)
  final List? genres;
  // @HiveField(9)
  // late bool isWatchlist;

  HiveMovie({
    required this.id,
    required this.title,
    required this.overview,
    required this.imageUrl,
    required this.director,
    required this.duration,
    required this.rating,
    required this.year,
    required this.genres,
    // this.isWatchlist = false,
  });

  factory HiveMovie.toHive(Movie movie) {
    return HiveMovie(
      id: movie.id,
      title: movie.title,
      overview: movie.overview,
      imageUrl: movie.imageUrl,
      director: movie.director,
      duration: movie.duration,
      rating: movie.rating,
      year: movie.year,
      genres: movie.genres,
    );
  }
}

@HiveType(typeId: 1)
class HiveTopMovies extends HiveObject {
  @HiveField(0)
  final String titleId;

  HiveTopMovies({
    required this.titleId,
  });
}

// class HiveMoviesList extends HiveObject {
//   @HiveField(0)
//   final List<HiveMovie> trendingMovies;
//   @HiveField(1)
//   final List<HiveMovie> topRatedMovies;
//   @HiveField(2)
//   final List<HiveMovie> watchlistMovies;

//   HiveMoviesList({
//     required this.trendingMovies,
//     required this.topRatedMovies,
//     required this.watchlistMovies,
//   });
// }
