import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/cloud_firestore/firestore_movie.dart';
import '../data/cloud_firestore/top_movies_dao.dart';
import '../network/http_service.dart';
import '../ui/widgets/loading_widget.dart';
import '../ui/widgets/movie_card.dart';
import 'movie_details_screen.dart';

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

  @override
  Widget build(BuildContext context) {
    final movieDao = Provider.of<TopMoviesDao>(context, listen: false);
    return RefreshIndicator(
      onRefresh: () async {
        await getOverviewDetails();
        setState(() {});
      },
      child: StreamBuilder<QuerySnapshot<FirestoreMovie>>(
        stream: movieDao.getMovies(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }

          if (!snapshot.hasData) {
            return const LoadingWidget();
          }

          final data = snapshot.requireData;

          if (data.docs.isEmpty) {
            getOverviewDetails();
            return const LoadingWidget();
          }

          return ListView.builder(
            itemCount: data.size,
            itemBuilder: (context, index) {
              final movie = data.docs[index].data().toMovie();
              movie.documentId = data.docs[index].reference.id;
              return MovieCard(
                movie: movie,
                onTap: () => Navigator.of(context).pushNamed(
                  MovieDetailsScreen.routeName,
                  arguments: movie,
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<bool> moviesDidNotChange(List<String> apiMovies) async {
    final currentmovies =
        await Provider.of<TopMoviesDao>(context, listen: false)
            .reference
            .orderBy('dateAdded')
            .get()
            .then((value) => value.docs.map((e) => e.data().titleId).toList());
    return listEquals(apiMovies, currentmovies);
  }

  Future<void> getOverviewDetails() async {
    final apiTopMovies = await HttpService().getTopMovies();
    final didNotChange = await moviesDidNotChange(apiTopMovies);
    if (didNotChange) {
      return;
    }
    for (var titleId in apiTopMovies) {
      final movie = await HttpService().getMovieDetails(tconst: titleId);
      final director = await HttpService().getDirector(tconst: titleId);
      final actorsProfile =
          await HttpService().getActorsProfile(tconst: titleId);
      movie.director = director;
      movie.actorsProfile = actorsProfile;
      Provider.of<TopMoviesDao>(context, listen: false).addMovie(movie);
    }
    // Provider.of<MovieDao>(context, listen: false).addMovies(movies);
  }
}
