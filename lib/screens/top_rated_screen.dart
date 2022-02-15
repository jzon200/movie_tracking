import 'package:flutter/material.dart';

import '../models/movie.dart';
import '../network/http_service.dart';

class TopRatedScreen extends StatefulWidget {
  const TopRatedScreen({Key? key}) : super(key: key);

  @override
  State<TopRatedScreen> createState() => _TopRatedScreenState();
}

class _TopRatedScreenState extends State<TopRatedScreen> {
  @override
  void initState() {
    super.initState();
  }

  Future<List<String>> getTopRatedMovies() async {
    final movies = await HttpService().getTopMovies();
    return movies;
  }

  Future<List<Movie>> getOverviewDetails() async {
    final apiTopMovies = await getTopRatedMovies();
    final movies = <Movie>[];
    for (var titleId in apiTopMovies) {
      final movie = await HttpService().getMovieDetails(tconst: titleId);
      // final casts = await getActorsInfo(tconst: titleId);
      // final director = await HttpService().getDirector(tconst: titleId);
      // movie.cast = casts;
      // movie.director = director;
      movies.add(movie);
    }
    return movies;
  }

  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.green);
    // final repository = Provider.of<TopRatedRepository>(context, listen: false);
    // return FutureBuilder<List<Movie>>(
    //   future:
    //       getOverviewDetails().then((values) => repository.addMovies(values)),
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
    //       // inErrorState = false;
    //       return MovieList(movies: query);
    //     } else {
    //       return const Center(
    //         child: SpinKitSquareCircle(
    //           color: Colors.blueAccent,
    //           size: 75,
    //         ),
    //       );
    //     }
    //   },
    // );
  }
}
