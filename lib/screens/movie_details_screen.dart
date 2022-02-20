import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/cloud_firestore/firestore_movie.dart';
import '../data/cloud_firestore/trending_movies_dao.dart';
import '../data/cloud_firestore/watchlist_dao.dart';
import '../models/movie.dart';
import '../models/user_ratings.dart';
import '../ui/color.dart';
import '../ui/widgets/add_watchlist_button.dart';
import '../ui/widgets/background_gradient.dart';
import '../ui/widgets/genre_chip.dart';
import '../ui/widgets/recommendations_list.dart';

class MovieDetailsScreen extends StatefulWidget {
  static const routeName = '/movie-details';

  const MovieDetailsScreen({Key? key}) : super(key: key);

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final watchlistDao = Provider.of<WatchlistDao>(context, listen: false);
    final trendingMoviesDao =
        Provider.of<TrendingMoviesDao>(context, listen: false);
    final movie = ModalRoute.of(context)!.settings.arguments as Movie;
    // TODO: Clean the code in the future ;]
    return Scaffold(
      body: SafeArea(
        child: ListView(
          primary: true,
          children: [
            SizedBox(
              height: 1680,
              child: Stack(
                children: [
                  // Banner
                  if (movie.imageUrl != null)
                    CachedNetworkImage(
                      imageUrl: movie.imageUrl!,
                      imageBuilder: (context, imageProvider) => Align(
                        alignment: const Alignment(0.0, -1.5),
                        child: Container(
                          height: 1207,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: const BackgroundGradient(),
                        ),
                      ),
                    ),
                  // Back button
                  _buildBackButton(context),
                  // Movie Details
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 1314,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(16.0),
                        ),
                        color: darkGray,
                      ),
                      child: Container(
                        margin: const EdgeInsets.only(top: 200),
                        padding: const EdgeInsets.only(
                          left: 16,
                          right: 16,
                          bottom: 32,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Overview',
                              style: Theme.of(context).textTheme.headline3,
                            ),
                            const SizedBox(height: 16),
                            Visibility(
                              visible: movie.overview!.length < 250,
                              child: Text(movie.overview!,
                                  style: Theme.of(context).textTheme.bodyText1!
                                  // .copyWith(color: Colors.black),
                                  ),
                            ),
                            Visibility(
                              visible: movie.overview!.length > 250,
                              child: SizedBox(
                                height: 70,
                                child: Stack(
                                  children: [
                                    Text(movie.overview!,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                        // .copyWith(color: Colors.black),
                                        ),
                                    Container(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: FractionalOffset.topCenter,
                                          end: FractionalOffset.bottomCenter,
                                          stops: const [0.4, 1.0],
                                          colors: [
                                            darkGray.withOpacity(0.0),
                                            darkGray,
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Visibility(
                              visible: movie.overview!.length > 250,
                              child: Center(
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Text(
                                    'READ MORE',
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption!
                                        .copyWith(
                                          color: Colors.lightBlue,
                                          letterSpacing: 3.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Cast',
                              style: Theme.of(context).textTheme.headline3,
                            ),
                            const SizedBox(height: 16),
                            _buildCastAvatarList(movie),
                            const SizedBox(height: 16),
                            (movie.rating != null)
                                ? // Ratings List
                                _buildRatingsList(ratings: movie.rating!)
                                : Text(
                                    'No ratings yet',
                                    style:
                                        Theme.of(context).textTheme.headline3,
                                  ),
                            const SizedBox(height: 32),
                            Text(
                              'You May Also Like',
                              style: Theme.of(context).textTheme.headline3,
                            ),
                            const SizedBox(height: 16),
                            // Movie Card
                            StreamBuilder<QuerySnapshot<FirestoreMovie>>(
                              stream: trendingMoviesDao.getMovies(),
                              builder: (context, snapshot) {
                                if (snapshot.hasError) {
                                  return Center(
                                    child: Text(snapshot.error.toString()),
                                  );
                                }

                                if (!snapshot.hasData) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }

                                final data = snapshot.requireData;

                                return RecommendationsList(
                                  items: data.docs
                                      .where((element) =>
                                          movie.documentId !=
                                          element.reference.id)
                                      .toList(),
                                );
                              },
                            ),

                            const Spacer(),
                            // Add To Watchlist button
                            StreamBuilder<QuerySnapshot<FirestoreMovie>>(
                              stream: watchlistDao.getMovies(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.active) {
                                  final data = snapshot.requireData;
                                  final watchlistData = data.docs
                                      .map((e) => e.reference.id)
                                      .toList();
                                  final isWatchlist =
                                      watchlistData.contains(movie.documentId);
                                  return AddWatchlistButton(
                                    movie: movie,
                                    onPressed: () {
                                      if (isWatchlist) {
                                        watchlistDao.removeFromWatchlist(movie);
                                      } else {
                                        watchlistDao.addToWatchlist(movie);
                                      }
                                    },
                                    isWatchlist: isWatchlist,
                                  );
                                } else {
                                  return AddWatchlistButton(
                                    movie: movie,
                                    onPressed: () {},
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Movie Poster
                  _buildMoviePoster(movie),
                  // Movie Headline
                  _buildMovieHeadline(movie, context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMovieHeadline(Movie movie, BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        width: 200,
        height: 200,
        margin: const EdgeInsets.only(
          top: 400.0,
          right: 8.0,
          left: 8.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AutoSizeText(
              movie.title!,
              minFontSize: 17,
              maxFontSize: 24,
              maxLines: 2,
              style: Theme.of(context)
                  .textTheme
                  .headline2!
                  .copyWith(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 16),
            FittedBox(
              child: Wrap(
                spacing: 16.0,
                children: [
                  Text(
                    movie.year.toString(),
                    style: Theme.of(context).textTheme.bodyText1!,
                  ),
                  Text(
                    '${(movie.duration! / 60).floor()}h ${movie.duration! % 60}min',
                    style: Theme.of(context).textTheme.bodyText1!,
                  ),
                  Text(
                    movie.director ?? '',
                    style: Theme.of(context).textTheme.bodyText1!,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            FittedBox(
              child: Wrap(
                spacing: 8,
                children: movie.genres!
                    .take(3)
                    .map((data) => GenreChip(text: data))
                    .toList(),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildMoviePoster(Movie movie) {
    return Positioned(
      left: 16,
      top: 320,
      child: Container(
        height: 221,
        width: 157,
        decoration: BoxDecoration(
          image: (movie.imageUrl != null)
              ? DecorationImage(
                  image: CachedNetworkImageProvider(movie.imageUrl!),
                  fit: BoxFit.cover,
                )
              : null,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: gray,
            width: 3.0,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 4,
              spreadRadius: 0,
              offset: const Offset(0, 4),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCastAvatarList(Movie movie) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 70,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, index) => CircleAvatar(
                foregroundImage: (movie.actorsProfile != null &&
                        movie.actorsProfile![index] != null)
                    ? CachedNetworkImageProvider(movie.actorsProfile![index]!)
                    : const CachedNetworkImageProvider(
                        'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png'),
                radius: 43.75,
                backgroundColor: gray,
              ),
              separatorBuilder: (_, index) => const SizedBox(width: 16),
              itemCount: (movie.actorsProfile != null)
                  ? movie.actorsProfile!.length
                  : 5,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return Positioned(
      top: 36,
      left: 16,
      child: GestureDetector(
        onTap: () => Navigator.of(context).pushReplacementNamed('/'),
        child: Container(
          width: 61,
          height: 61,
          decoration: const BoxDecoration(
            color: darkGray,
            shape: BoxShape.circle,
          ),
          child: const Center(
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRatingsList({
    List<UserRatings> users = UserRatings.userRatings,
    double? ratings,
  }) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'Ratings  -  4',
                style: Theme.of(context).textTheme.headline3!,
              ),
            ),
            Text(
              '$ratings',
              style: Theme.of(context).textTheme.headline1!,
            ),
            const SizedBox(width: 6),
            Expanded(
              child: SizedBox(
                height: 20,
                child: ListView.builder(
                  primary: false,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 5,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, index) {
                    final rating = ratings! / 2;
                    return Container(
                      margin: const EdgeInsets.only(left: 8),
                      child: Icon(
                        Icons.star,
                        color: (rating.toInt() > index) ? yellow : gray,
                        size: 20,
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
        ...users
            .map(
              (user) => ListTile(
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(
                  foregroundImage: AssetImage(user.imagePath),
                  backgroundColor: gray,
                ),
                title: Text(
                  '${user.name} - ${user.date}',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                subtitle: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 20,
                        child: ListView.builder(
                          primary: false,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 5,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (_, index) => Container(
                            margin: const EdgeInsets.only(right: 8),
                            child: Icon(
                              Icons.star,
                              color: (user.rating > index) ? yellow : gray,
                              size: 12,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
            .toList()
      ],
    );
  }
}
