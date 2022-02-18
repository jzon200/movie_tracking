import '../../models/movie.dart';

class FirestoreMovie {
  final String? titleId;
  final String? title;
  final String? overview;
  final String? imageUrl;
  final int? duration;
  final double? rating;
  final int? year;
  final List<String>? genres;
  String? documentId;
  String? director;
  List<String?>? actorsProfile;
  final DateTime dateAdded = DateTime.now();
  // bool isWatchlist;

  FirestoreMovie({
    this.titleId,
    this.title,
    this.overview,
    this.imageUrl,
    this.duration,
    this.rating,
    this.year,
    this.genres,
    this.director,
    this.documentId,
    this.actorsProfile,
    // this.isWatchlist = false,
  });

  factory FirestoreMovie.fromJson(Map<String, Object?> json) {
    return FirestoreMovie(
      titleId: json['id'] as String?,
      title: json['title'] as String?,
      overview: json['overview'] as String?,
      imageUrl: json['imageUrl'] as String?,
      duration: json['duration'] as int?,
      rating: json['rating'] as double?,
      year: json['year'] as int?,
      genres: (json['genres'] as List).cast<String>(),
      director: json['director'] as String?,
      // isWatchlist: json['isWatchlist'] as bool,
      actorsProfile: (json['actorsProfile'] as List?)!.cast<String?>(),
    );
  }

  Map<String, Object?> toJson() {
    return {
      'id': titleId,
      'title': title,
      'overview': overview,
      'imageUrl': imageUrl,
      'duration': duration,
      'rating': rating,
      'year': year,
      'genres': genres,
      'director': director,
      'dateAdded': dateAdded,
      // 'isWatchlist': isWatchlist,
      'actorsProfile': actorsProfile,
    };
  }

  Movie toMovie() {
    return Movie(
      titleId: titleId,
      title: title,
      overview: overview,
      imageUrl: imageUrl,
      duration: duration,
      rating: rating,
      year: year,
      genres: genres,
      director: director,
      // isWatchlist: isWatchlist,
      actorsProfile: actorsProfile,
    );
  }
}
