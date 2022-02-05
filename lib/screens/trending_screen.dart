import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:movie_tracking/data/movies_repository.dart';
import 'package:provider/provider.dart';
import '../network/http_service.dart';

import '../models/movie.dart';
import '../ui/widgets/movie_card.dart';
import 'movie_details_screen.dart';

class TrendingScreen extends StatefulWidget {
  const TrendingScreen({Key? key}) : super(key: key);

  @override
  State<TrendingScreen> createState() => _TrendingScreenState();
}

class _TrendingScreenState extends State<TrendingScreen> {
  bool isLoading = true;
  bool inErrorState = false;
  // List movieDetails = [];

  @override
  void initState() {
    super.initState();
    // getPopularMovies();
  }

  // @override
  // void dispose() {
  //   Hive.close();
  //   super.dispose();
  // }

  // Future<void> getPopularMovies() async {
  //   final popularMovies = await MovieApi.getPopularMovies();
  //   for (var i = 0; i < 5; i++) {
  //     // if (i == 1) continue;
  //     final details = await MovieApi.getDetails(popularMovies[i].title);
  //     movieDetails.add(details);
  //   }
  //   // final details = await MovieApi.getDetails(popularMovies[0].title);
  //   // movieDetails.add(details);
  //   setState(() {
  //     isLoading = false;
  //   });
  //   // print(popularMovies);
  //   print(movieDetails);
  // }

  Future<List<Movie>> getTrendingDetails() async {
    final popularMovies = await HttpService().getPopularMovies();
    final movieDetails = <Movie>[];
    for (var i = 0; i < 5; i++) {
      final details =
          await HttpService().getMovieDetails(tconst: popularMovies[i].title);
      movieDetails.add(details);
    }
    return movieDetails;
  }

  @override
  Widget build(BuildContext context) {
    return _buildMovieLoader(context);
  }

  ListView _buildMovieList(BuildContext context, List<Movie> items) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (_, index) {
        final movie = items[index];
        return MovieCard(
          movie: movie,
          onTap: () => Navigator.of(context).pushNamed(
            MovieDetailsScreen.routeName,
            arguments: movie,
          ),
        );
      },
    );
  }

  Widget _buildMovieLoader(BuildContext context) {
    final repository = Provider.of<MoviesRepository>(context, listen: false);
    final movies = repository.findMovies();
    return movies.isNotEmpty
        ? _buildMovieList(context, repository.findMovies())
        : FutureBuilder<List<Movie>>(
            // future: MovieService.create().queryMovies('tt0944947', 'US'),
            future: getTrendingDetails().then((value) =>
                Provider.of<MoviesRepository>(context, listen: false)
                    .insertMovies(value)),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      snapshot.error.toString(),
                      textAlign: TextAlign.center,
                      textScaleFactor: 1.3,
                    ),
                  );
                }
                isLoading = false;
                final movies = snapshot.data ?? [];
                inErrorState = false;
                return _buildMovieList(context, movies);
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          );
  }
}
