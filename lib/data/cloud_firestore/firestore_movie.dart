import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/cast.dart';
import '../../models/movie.dart';

class FirestoreMovie {
  final String? id;
  final String? title;
  final String? overview;
  final String? imageUrl;
  final int? duration;
  final double? rating;
  final int? year;
  final List<String>? genres;
  String? director;
  List<String?>? actorsProfile;
  String? reference;
  final DateTime dateAdded = DateTime.now();
  bool isWatchlist;
  // List<Cast>? cast;

  FirestoreMovie({
    this.id,
    this.title,
    this.overview,
    this.imageUrl,
    this.duration,
    this.rating,
    this.year,
    this.genres,
    this.director,
    this.reference,
    this.actorsProfile,
    this.isWatchlist = false,
    // this.cast,
  });

  factory FirestoreMovie.fromJson(Map<String, Object?> json, String id) {
    return FirestoreMovie(
      id: json['id'] as String?,
      title: json['title'] as String?,
      overview: json['overview'] as String?,
      imageUrl: json['imageUrl'] as String?,
      duration: json['duration'] as int?,
      rating: json['rating'] as double?,
      year: json['year'] as int?,
      genres: (json['genres'] as List).cast<String>(),
      director: json['director'] as String?,
      isWatchlist: json['isWatchlist'] as bool,
      actorsProfile: (json['actorsProfile'] as List?)!.cast<String?>(),
      reference: id,
      // cast: (json['cast'] as List).map((e) => Cast.fromJson(e)).toList(),
    );
  }

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'title': title,
      'overview': overview,
      'imageUrl': imageUrl,
      'duration': duration,
      'rating': rating,
      'year': year,
      'genres': genres,
      'director': director,
      'dateAdded': dateAdded,
      'isWatchlist': isWatchlist,
      'actorsProfile': actorsProfile,
      // 'cast': cast,
    };
  }

  Movie toMovie() {
    return Movie(
      id: id,
      title: title,
      overview: overview,
      imageUrl: imageUrl,
      duration: duration,
      rating: rating,
      year: year,
      genres: genres,
      director: director,
      isWatchlist: isWatchlist,
      actorsProfile: actorsProfile,
      // cast: cast,
    );
  }

  // factory FirestoreMovie.fromSnapshot(DocumentSnapshot snapshot) {
  //   final movie =
  //       FirestoreMovie.fromJson(snapshot.data() as Map<String, Object?>);
  //   // print(movie);
  //   movie.reference = snapshot.reference;
  //   return movie;
  // }
}
