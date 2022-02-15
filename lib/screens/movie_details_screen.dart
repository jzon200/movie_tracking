import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:movie_tracking/data/cloud_firestore/movie_dao.dart';
import 'package:movie_tracking/data/cloud_firestore/watchlist_dao.dart';
import 'package:movie_tracking/data/hive/hive_repository.dart';
import 'package:provider/provider.dart';

import '../data/cloud_firestore/firestore_movie.dart';
import '../data/hive/hive_db.dart';
import '../models/movie.dart';
import '../models/user_ratings.dart';
import '../ui/app_theme.dart';
import '../ui/color.dart';
import '../ui/widgets/add_watchlist_button.dart';
import '../ui/widgets/background_gradient.dart';
import '../ui/widgets/recommendations_list.dart';

class MovieDetailsScreen extends StatefulWidget {
  static const routeName = '/movie-details';
  const MovieDetailsScreen({Key? key}) : super(key: key);

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  bool _isWatchlist = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final watchlistDao = Provider.of<WatchlistDao>(context, listen: false);
  }
  // @override
  // void dispose() {
  //   Hive.close();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final watchlistDao = Provider.of<WatchlistDao>(context, listen: false);
    final movieDao = Provider.of<MovieDao>(context, listen: false);
    final movie = ModalRoute.of(context)!.settings.arguments as Movie;
    print(movie.id);
    print(movie.reference);
    // print(movie.reference);
    // final movies = watchlistDao.getMovies();
    // watchlistDao.isWatchlist(movie);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
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
                            isAntiAlias: true,
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
                                      style:
                                          Theme.of(context).textTheme.bodyText1!
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
                                  style: Theme.of(context).textTheme.headline3,
                                ),
                          const SizedBox(height: 32),
                          Text(
                            'You May Also Like',
                            style: Theme.of(context).textTheme.headline3,
                          ),
                          const SizedBox(height: 16),
                          // Movie Card
                          StreamBuilder<QuerySnapshot<FirestoreMovie>>(
                            stream: movieDao.getMovies(),
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
                                    .where((element) => element.id != movie.id)
                                    .toList(),
                              );
                            },
                          ),

                          // Add To Watchlist button
                          const Spacer(),
                          AddWatchlistButton(
                            movie: movie,
                            onPressed: () {
                              setState(() {
                                if (!movie.isWatchlist) {
                                  watchlistDao.addToWatchlist(movie);
                                } else {
                                  watchlistDao.removeFromWatchlist(movie);
                                }
                              });
                            },
                            isWatchlist: movie.isWatchlist,
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
              minFontSize: 18,
              maxFontSize: 24,
              style: Theme.of(context).textTheme.headline2!.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
            const SizedBox(height: 16),
            FittedBox(
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(movie.year.toString(),
                      style: Theme.of(context).textTheme.bodyText1!),
                  const SizedBox(width: 16),
                  Text(
                      '${(movie.duration! / 60).floor()}h ${movie.duration! % 60}min',
                      style: Theme.of(context).textTheme.bodyText1!
                      // .copyWith(color: Colors.black),
                      ),
                  const SizedBox(width: 16),
                  Text(movie.director ?? '',
                      style: Theme.of(context).textTheme.bodyText1!
                      // .copyWith(color: Colors.black),
                      ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            FittedBox(
              child: Row(
                children: movie.genres!
                    .take(3)
                    .map((data) => Container(
                          margin: const EdgeInsets.only(right: 8),
                          padding: const EdgeInsets.symmetric(
                            vertical: 2,
                            horizontal: 8,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.white,
                            border: Border.all(
                              color: blue,
                            ),
                          ),
                          child: Text(
                            data.toUpperCase(),
                            style: Theme.of(context)
                                .textTheme
                                .headline5!
                                .copyWith(color: blue),
                          ),
                        ))
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
            color: Colors.white,
            width: 5.0,
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
                    : null,
                radius: 43.75,
                backgroundColor: const Color(0xFFC4C4C4),
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
              child: Text('Ratings - 4',
                  style: Theme.of(context).textTheme.headline3!
                  // .copyWith(color: Colors.black),
                  ),
            ),
            Text('$ratings', style: Theme.of(context).textTheme.headline1!
                // .copyWith(color: Colors.black),
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
                        color: (rating.toInt() > index) ? yellow : Colors.grey,
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
                  backgroundColor: const Color(0xFFC4C4C4),
                ),
                title: Text(
                  '${user.name} - ${user.date}',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(color: grey),
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
                              color:
                                  (user.rating > index) ? yellow : Colors.grey,
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
