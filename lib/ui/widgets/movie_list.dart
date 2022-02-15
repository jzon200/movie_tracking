import 'package:flutter/material.dart';
import 'package:movie_tracking/data/hive/hive_db.dart';

import '../../models/movie.dart';
import '../../screens/movie_details_screen.dart';
import 'movie_card.dart';

class MovieList extends StatelessWidget {
  const MovieList({Key? key, required this.movies}) : super(key: key);

  final List<Movie> movies;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: movies.length,
      itemBuilder: (_, index) {
        // final hiveMovie = movies[index];
        // final movie = Movie.fromHive(hiveMovie);
        final movie = movies[index];
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
