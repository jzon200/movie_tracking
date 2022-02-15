import 'package:chopper/chopper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movie_tracking/data/cloud_firestore/watchlist_dao.dart';
import 'package:movie_tracking/ui/widgets/movie_card.dart';
import 'package:provider/provider.dart';
import 'package:movie_tracking/data/cloud_firestore/firestore_movie.dart';

import '../data/hive/hive_db.dart';
import '../models/movie.dart';
import '../ui/widgets/movie_list.dart';
import 'movie_details_screen.dart';

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
    final watchlistDao = Provider.of<WatchlistDao>(context, listen: false);
    return StreamBuilder<QuerySnapshot<FirestoreMovie>>(
      stream: watchlistDao.getMovies(),
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
            movie.isWatchlist = data.docs
                .map((e) => e.reference.id)
                .toList()
                .contains(movie.reference);
            // print(data.docs[index].reference.id);

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
  }
}
