import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movie_tracking/data/cloud_firestore/firestore_movie.dart';
// import 'package:movie_tracking/data/cloud_firestore/movie.dart';
import '../../models/movie.dart';

class MovieDao {
  final moviesRef = FirebaseFirestore.instance
      .collection('trending_movies')
      .withConverter<FirestoreMovie>(
          fromFirestore: ((snapshot, _) =>
              FirestoreMovie.fromJson(snapshot.data()!, snapshot.reference.id)),
          toFirestore: (movie, _) => movie.toJson());
  final CollectionReference collection =
      FirebaseFirestore.instance.collection('trending_movies');

  void addMovie(Movie movie) {
    moviesRef.add(movie.toFirestore());
    // final casts = movie.cast!.map((e) => e.toJson(e)).toList();
    // collection.doc('cast' :).collection(cast);
  }

  Stream<QuerySnapshot<FirestoreMovie>> getMovies() {
    return moviesRef.orderBy('dateAdded').snapshots();
  }

  void addMovies(List<Movie> movies) {
    for (var movie in movies) {
      // print(movie);
      moviesRef.add(movie.toFirestore());
    }
    // return movies;
    // return Future.value();
  }
}
