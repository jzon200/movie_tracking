import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movie_tracking/data/hive/hive_db.dart';
import 'package:movie_tracking/data/hive/hive_repository.dart';
import 'package:movie_tracking/screens/movie_details_screen.dart';
import '../data/watchlist_repository.dart';
import '../models/movie.dart';
import '../ui/widgets/movie_card.dart';
import 'package:provider/provider.dart';

class WatchListScreen extends StatefulWidget {
  const WatchListScreen({Key? key}) : super(key: key);

  @override
  State<WatchListScreen> createState() => _WatchListScreenState();
}

class _WatchListScreenState extends State<WatchListScreen> {
  // @override
  // void dispose() {
  //   Hive.close();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    // final repository = Provider.of<HiveRepository>(context, listen: false);
    return ValueListenableBuilder<Box<HiveMovie>>(
        valueListenable: Hive.box<HiveMovie>('movies').listenable(),
        builder: (context, box, _) {
          final watchlist = box.values.toList().cast<HiveMovie>();
          return ListView.builder(
            itemBuilder: (context, index) {
              final hiveMovie = watchlist[index];
              final movie = Movie(
                id: hiveMovie.id,
                title: hiveMovie.title,
                imageUrl: hiveMovie.imageUrl,
                rating: hiveMovie.rating,
                duration: hiveMovie.duration,
                year: hiveMovie.year,
                overview: hiveMovie.overview,
                director: hiveMovie.director,
                genres: hiveMovie.genres,
              );
              return MovieCard(
                movie: movie,
                onTap: () {
                  Navigator.of(context).pushNamed(
                    MovieDetailsScreen.routeName,
                    arguments: movie,
                  );
                },
              );
            },
            itemCount: watchlist.length,
          );
        });
    // List<Movie> movies = [];
    // return Consumer<WatchlistRepository>(builder: (_, repository, child) {
    //   movies = repository.findMovies();
    //   return ListView.builder(
    //     itemCount: movies.length,
    //     itemBuilder: (_, index) {
    //       final movie = movies[index];
    //       return MovieCard(movie: movie);
    //     },
    //   );
    // });
  }
}
