import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hive/hive.dart';
import 'package:movie_tracking/data/hive/hive_repository.dart';
import 'package:movie_tracking/models/screen_arguments.dart';
import 'package:movie_tracking/screens/movie_details_screen.dart';
import 'package:movie_tracking/ui/widgets/movie_card.dart';
import 'package:provider/provider.dart';

import '../data/cloud_firestore/firestore_movie.dart';
import '../data/cloud_firestore/movie_dao.dart';
import '../data/cloud_firestore/firestore_movie.dart' as firestore;
import '../data/cloud_firestore/watchlist_dao.dart';
import '../data/hive/hive_db.dart';
import '../models/cast.dart';
import '../models/movie.dart';
import '../network/http_service.dart';
import '../ui/widgets/movie_list.dart';

class TrendingScreen extends StatefulWidget {
  const TrendingScreen({Key? key}) : super(key: key);

  @override
  State<TrendingScreen> createState() => _TrendingScreenState();
}

class _TrendingScreenState extends State<TrendingScreen> {
  // bool isLoading = true;
  // bool inErrorState = false;
  // final box = Hive.box<HiveMovie>('current_movies');
  // final box2 = Hive.box<HiveTopMovies>('top_movies');
  List<String> popularMoviesId = [];
  List<String> currentMoviesId = [];
  // bool moviesDidChange = true;
  // List movieDetails = [];

  @override
  void initState() {
    super.initState();
    // HttpService().getDirector(tconst: 'tt0944947');
    // getActorsInfo();
    // getPopularMovies();
  }

  // @override
  // void dispose() {
  //   Hive.close();
  //   super.dispose();
  // }
  Future<List<String?>> getActorsProfile({required String tconst}) async {
    final topCast = await HttpService().getTopCast(tconst: tconst);
    final actorsProfilePic = <String?>[];
    for (var name in topCast) {
      final imageUrl = await HttpService().getActorProfileUrl(nconst: name);
      actorsProfilePic.add(imageUrl);
    }
    // print(actorsInfo);
    return actorsProfilePic;
  }

  Future<List<String>> getPopularMovies() async {
    final movies = await HttpService().getPopularMovies();
    return movies;
  }

  Future<List<Movie>> getOverviewDetails() async {
    final apiPopularMovies = await getPopularMovies();
    final movies = <Movie>[];
    for (var titleId in apiPopularMovies) {
      final movie = await HttpService().getMovieDetails(tconst: titleId);
      final director = await HttpService().getDirector(tconst: titleId);
      final actorsProfile = await getActorsProfile(tconst: titleId);
      movie.director = director;
      movie.actorsProfile = actorsProfile;
      movies.add(movie);
    }
    return movies;
  }

  @override
  Widget build(BuildContext context) {
    return _buildMovieLoader(context);
  }

  Widget _buildMovieLoader(BuildContext context) {
    final movieDao = Provider.of<MovieDao>(context, listen: false);
    return StreamBuilder<QuerySnapshot<FirestoreMovie>>(
      stream: movieDao.getMovies(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        }

        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final data = snapshot.requireData;

        return ListView.builder(
          itemCount: data.size,
          itemBuilder: (context, index) {
            final movie = data.docs[index].data().toMovie();
            movie.reference = data.docs[index].reference.id;
            // data.docs[index].exists;
            // movie.isWatchlist = data.docs
            //     .map((e) => e.reference.id)
            //     .toList()
            //     .contains(movie.reference);
            // print(movie.isWatchlist);
            return MovieCard(
              movie: movie,
              onTap: () => Navigator.of(context).pushNamed(
                MovieDetailsScreen.routeName,
                arguments: movie,
              ),
              // data.docs[index].reference,
            );
          },
        );
      },
    );
    // return FutureBuilder<List<Movie>>(
    //   future: getOverviewDetails(),
    //   builder: (context, snapshot) {
    //     if (snapshot.connectionState == ConnectionState.done) {
    //       if (snapshot.hasError) {
    //         return Center(
    //           child: Text(
    //             snapshot.error.toString(),
    //             textAlign: TextAlign.center,
    //             textScaleFactor: 1.3,
    //           ),
    //         );
    //       }
    //       // isLoading = false;
    //       final query = snapshot.data ?? [];
    //       // movieDao.addMovies(query);
    //       movieDao.addMovies(query);
    //       return MovieList(movies: query);
    //       // inErrorState = false;
    //       // return StreamBuilder<QuerySnapshot>(
    //       //   stream: movieDao.getMovies(),
    //       //   builder: (context, snapshot) {
    //       //     if (!snapshot.hasData) {
    //       //       return const Center(child: CircularProgressIndicator());
    //       //     }
    //       //     // return MovieList(movies: snapshot.data!.docs);
    //       //     return _buildList(context, snapshot.data!.docs);
    //       //   },
    //       // );
    //     } else {
    //       return const Center(child: CircularProgressIndicator());
    //     }
    //   },
    // );
  }

  // Widget _buildList(BuildContext context, List<DocumentSnapshot>? snapshot) {
  //   return ListView(
  //     children: snapshot!.map((data) => _buildListItem(context, data)).toList(),
  //   );
  // }

  // Widget _buildListItem(BuildContext context, DocumentSnapshot snapshot) {
  //   final cloudMovie = firestore.FirestoreMovie.fromSnapshot(snapshot);
  //   final movie = Movie(
  //     id: cloudMovie.id,
  //     title: cloudMovie.title,
  //     imageUrl: cloudMovie.imageUrl,
  //     overview: cloudMovie.overview,
  //     duration: cloudMovie.duration,
  //     director: cloudMovie.director,
  //     rating: cloudMovie.rating,
  //     year: cloudMovie.year,
  //     genres: cloudMovie.genres,
  //   );
  //   return MovieCard(movie: movie);
  // }
}
