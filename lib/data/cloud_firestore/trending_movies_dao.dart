import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movie_tracking/data/cloud_firestore/firestore_movie.dart';
import '../../models/movie.dart';

class TrendingMoviesDao {
  final reference = FirebaseFirestore.instance
      .collection('trending_movies')
      .withConverter<FirestoreMovie>(
          fromFirestore: (snapshot, _) =>
              FirestoreMovie.fromJson(snapshot.data()!),
          toFirestore: (movie, _) => movie.toJson());

  Future<void> addMovie(Movie movie) async {
    await reference.doc(movie.documentId).set(movie.toFirestore());
  }

  Stream<QuerySnapshot<FirestoreMovie>> getMovies() {
    return reference.orderBy('dateAdded').snapshots();
  }

  // Future<void> addMovies(List<Movie> movies) async {
  //   for (var movie in movies) {
  //     await reference.doc(movie.documentId).set(movie.toFirestore());
  //   }
  // }
}
