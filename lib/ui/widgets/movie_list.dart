import 'package:flutter/material.dart';

import '../../models/movie.dart';
import 'movie_card.dart';

class MovieList extends StatelessWidget {
  final List<Movie> movies;

  const MovieList({Key? key, required this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: movies.length,
      itemBuilder: (_, index) {
        final movie = movies[index];
        return MovieCard(
          movie: movie,
        );
      },
    );
  }
}
