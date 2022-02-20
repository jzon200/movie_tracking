import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movie_tracking/data/cloud_firestore/firestore_movie.dart';
import '../../models/movie.dart';

class WatchlistDao {
  final reference = FirebaseFirestore.instance
      .collection('watchlist')
      .withConverter<FirestoreMovie>(
          fromFirestore: (snapshot, _) =>
              FirestoreMovie.fromJson(snapshot.data()!),
          toFirestore: (movie, _) => movie.toJson());

  Future<void> addToWatchlist(Movie movie) async {
    await reference.doc(movie.documentId).set(movie.toFirestore());
  }

  Future<void> removeFromWatchlist(Movie movie) async {
    await reference.doc(movie.documentId).delete();
  }

  Stream<QuerySnapshot<FirestoreMovie>> getMovies() {
    return reference.orderBy('dateAdded').snapshots();
  }
}
