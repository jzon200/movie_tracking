import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../data/cloud_firestore/firestore_movie.dart';
import '../data/cloud_firestore/watchlist_dao.dart';
import '../models/movie.dart';
import '../models/tab_provider.dart';
import '../ui/color.dart';
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
          return Container();
        }

        final data = snapshot.requireData;

        if (data.docs.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: AspectRatio(
                      aspectRatio: 1 / 1,
                      child: SvgPicture.asset('assets/svg/home_cinema.svg'),
                    ),
                  ),
                  Text(
                    'No Movies on the Watchlist yet!',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Provider.of<TabProvider>(context, listen: false)
                          .goToMovies();
                    },
                    child: Text(
                      'Browse Movies',
                      style: Theme.of(context).textTheme.button,
                    ),
                    style: ElevatedButton.styleFrom(primary: blue),
                  )
                ],
              ),
            ),
          );
        }

        return ListView.separated(
          itemCount: data.size,
          padding: const EdgeInsets.all(12.0),
          itemBuilder: (context, index) {
            final movie = data.docs[index].data().toMovie();
            movie.documentId = data.docs[index].reference.id;
            return WatchlistItem(
              movie: movie,
            );
          },
          separatorBuilder: (context, index) => const SizedBox(height: 12),
        );
      },
    );
  }
}

class WatchlistItem extends StatelessWidget {
  final Movie movie;

  const WatchlistItem({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final watchlistDao = Provider.of<WatchlistDao>(context, listen: false);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          MovieDetailsScreen.routeName,
          arguments: movie,
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Dismissible(
          key: Key(movie.documentId!),
          direction: DismissDirection.endToStart,
          onDismissed: (direction) {
            watchlistDao.removeFromWatchlist(movie);
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${movie.title} removed!'),
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.grey[50],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                action: SnackBarAction(
                  label: 'UNDO',
                  onPressed: () {
                    watchlistDao.addToWatchlist(movie);
                  },
                ),
              ),
            );
          },
          background: Container(
            color: Theme.of(context).errorColor,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 14.0),
            child: const Icon(
              Icons.delete_sweep,
              color: Colors.white,
              size: 50.0,
            ),
          ),
          child: Container(
            // height: 160,
            color: const Color(0xFF1B1D26),
            child: Row(
              children: [
                CachedNetworkImage(
                  width: MediaQuery.of(context).size.width * 0.32,
                  imageUrl: movie.imageUrl ?? '',
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AutoSizeText(
                          movie.title ?? '',
                          minFontSize: 16,
                          maxFontSize: 20,
                          maxLines: 2,
                          style: Theme.of(context).textTheme.headline2,
                        ),
                        const SizedBox(height: 14),
                        FittedBox(
                          child: Wrap(
                            spacing: 12.0,
                            children: [
                              Text(
                                movie.year.toString(),
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              Text(
                                Movie.getDuration(movie.duration),
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              Text(
                                movie.director ?? '',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 14),
                        FittedBox(
                          child: Wrap(
                            spacing: 8.0,
                            children: movie.genres!
                                .take(3)
                                .map((genre) => Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0,
                                        vertical: 2.0,
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          width: 1.5,
                                          color: blue2,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: Text(
                                        genre,
                                        style: GoogleFonts.chivo(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: blue2,
                                        ),
                                      ),
                                    ))
                                .toList(),
                          ),
                        ),
                        const SizedBox(height: 14),
                        (movie.rating != null)
                            ? Row(
                                children: [
                                  AutoSizeText(
                                    '${movie.rating}',
                                    maxFontSize: 24,
                                    style:
                                        Theme.of(context).textTheme.headline1,
                                  ),
                                  const SizedBox(width: 6),
                                  SizedBox(
                                    height: 20,
                                    child: ListView.separated(
                                      primary: false,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: 5,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (_, index) {
                                        final rating = (movie.rating! / 2);
                                        return Icon(
                                          Icons.star,
                                          color: (rating.toInt() > index)
                                              ? yellow
                                              : gray,
                                          size: 20,
                                        );
                                      },
                                      separatorBuilder: (_, __) =>
                                          const SizedBox(width: 8),
                                    ),
                                  ),
                                ],
                              )
                            : Text(
                                'No ratings yet',
                                style: Theme.of(context).textTheme.headline3,
                              ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
