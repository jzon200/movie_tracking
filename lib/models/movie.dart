import '../data/cloud_firestore/firestore_movie.dart';

class Movie {
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

  Movie({
    this.documentId,
    this.titleId,
    this.title,
    this.imageUrl,
    this.overview,
    this.director,
    this.duration,
    this.rating,
    this.year,
    this.genres,
    this.actorsProfile,
  });

  @override
  String toString() {
    return {
      'id': titleId,
      'title': title,
      'overview': overview,
      'imageUrl': imageUrl,
      'director': director,
      'duration': duration,
      'rating': rating,
      'year': year,
      'genres': genres,
    }.toString();
  }

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      titleId: json['id'],
      title: json['title']['title'],
      overview: json['plotOutline']['text'],
      imageUrl: json['title']['image']['url'],
      duration: json['title']['runningTimeInMinutes'],
      rating: json['ratings']['rating'],
      year: json['title']['year'],
      genres: json['genres'].cast<String>(),
    );
  }

  FirestoreMovie toFirestore() {
    return FirestoreMovie(
      titleId: titleId,
      title: title,
      overview: overview,
      imageUrl: imageUrl,
      duration: duration,
      rating: rating,
      year: year,
      genres: genres,
      director: director,
      actorsProfile: actorsProfile,
    );
  }

  static String getDuration(int? duration) {
    if (duration == null) {
      return '';
    }
    return '${(duration / 60).floor()}h ${duration % 60}min';
  }
}
