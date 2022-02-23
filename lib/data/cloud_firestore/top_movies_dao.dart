import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/movie.dart';
import 'firestore_movie.dart';

class TopMoviesDao {
  final reference = FirebaseFirestore.instance
      .collection('top_movies')
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
}
