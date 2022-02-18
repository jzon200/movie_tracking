import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/cloud_firestore/firestore_movie.dart';
import '../data/cloud_firestore/watchlist_dao.dart';
import '../ui/widgets/loading_widget.dart';
import '../ui/widgets/movie_card.dart';
import 'movie_details_screen.dart';

class WatchListScreen extends StatefulWidget {
  const WatchListScreen({Key? key}) : super(key: key);

  @override
  State<WatchListScreen> createState() => _WatchListScreenState();
}

class _WatchListScreenState extends State<WatchListScreen> {
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
          return const LoadingWidget();
        }

        final data = snapshot.requireData;

        if (data.docs.isEmpty) {
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
    );
  }
}
