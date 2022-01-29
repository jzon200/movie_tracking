import 'package:flutter/material.dart';
import 'package:movie_tracking/network/movie_api.dart';

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
  List movieDetails = [];

  @override
  void initState() {
    super.initState();
    getPopularMovies();
  }

  Future<void> getPopularMovies() async {
    final popularMovies = await MovieApi.getPopularMovies();
    for (var i = 0; i < 6; i++) {
      // if (i == 1) continue;
      final details = await MovieApi.getDetails(popularMovies[i].title);
      movieDetails.add(details);
    }
    // final details = await MovieApi.getDetails(popularMovies[0].title);
    // movieDetails.add(details);
    setState(() {
      isLoading = false;
    });
    // print(popularMovies);
    print(movieDetails);
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : ListView.builder(
            itemCount: movieDetails.length,
            itemBuilder: (_, index) {
              final movie = movieDetails[index];
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
}
