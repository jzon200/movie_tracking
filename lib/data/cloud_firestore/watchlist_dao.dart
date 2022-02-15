import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movie_tracking/data/cloud_firestore/firestore_movie.dart';
import '../../models/movie.dart';

class WatchlistDao {
  final CollectionReference collection =
      FirebaseFirestore.instance.collection('watchlist');
  final moviesRef = FirebaseFirestore.instance
      .collection('trending_movies')
      .withConverter<FirestoreMovie>(
          fromFirestore: ((snapshot, _) =>
              FirestoreMovie.fromJson(snapshot.data()!, snapshot.reference.id)),
          toFirestore: (movie, _) => movie.toJson());
  final watchlistRef = FirebaseFirestore.instance
      .collection('watchlist')
      .withConverter<FirestoreMovie>(
          fromFirestore: ((snapshot, _) =>
              FirestoreMovie.fromJson(snapshot.data()!, snapshot.reference.id)),
          toFirestore: (movie, _) => movie.toJson());

  Future<void> addToWatchlist(Movie movie) async {
    movie.isWatchlist = true;
    print(movie.reference);
    await watchlistRef.doc(movie.reference).set(movie.toFirestore());
    await moviesRef.doc(movie.reference).update({'isWatchlist': true});
  }

  Future<void> removeFromWatchlist(Movie movie) async {
    movie.isWatchlist = false;
    moviesRef.doc(movie.reference).update({'isWatchlist': false});
    await watchlistRef
        .doc(movie.reference)
        .delete()
        .then((value) => print("User Deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  }

  Future<bool> doesExist(Movie movie) async {
    final doesExist = await watchlistRef.get().then((value) => value.docs
        .map((e) => e.reference.id)
        .toList()
        .contains(movie.reference));
    return doesExist;
  }

  Stream<QuerySnapshot<FirestoreMovie>> getMovies() {
    return watchlistRef.orderBy('dateAdded').snapshots();
  }
}
