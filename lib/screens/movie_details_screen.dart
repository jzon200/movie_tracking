import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:movie_tracking/data/hive/hive_db.dart';
import 'package:movie_tracking/data/hive/hive_repository.dart';
import '../data/movies_repository.dart';
import '../data/watchlist_repository.dart';
import 'package:provider/provider.dart';
import '../ui/app_theme.dart';
import '../ui/widgets/movie_card.dart';

import '../models/movie.dart';
import '../ui/widgets/background_gradient.dart';

class MovieDetailsScreen extends StatefulWidget {
  static const routeName = '/movie-details';
  const MovieDetailsScreen({Key? key}) : super(key: key);

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  // @override
  // void dispose() {
  //   Hive.close();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final repository = Provider.of<WatchlistRepository>(context, listen: false);
    final movie = ModalRoute.of(context)!.settings.arguments as Movie;
    final box = Hive.box<HiveMovie>('movies');
    // final movies =
    //     Movie.movieInfo.where((element) => movie.id != element.id).toList();
    // movies.shuffle();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: 1680,
            child: Stack(
              children: [
                // Banner
                Align(
                  alignment: const Alignment(0.0, -1.5),
                  child: Container(
                    height: 1207,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        isAntiAlias: true,
                        image: NetworkImage(movie.imageUrl!),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: const BackgroundGradient(),
                  ),
                ),
                // Back button
                Positioned(
                  top: 36,
                  left: 16,
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      width: 61,
                      height: 61,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                // Movie Details
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 1314,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(16.0),
                      ),
                      color: Colors.white,
                    ),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        margin: const EdgeInsets.only(top: 180),
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
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3!
                                  .copyWith(color: Colors.black),
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              height: 115,
                              child: Stack(
                                children: [
                                  Text(
                                    movie.overview!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(color: Colors.black),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: FractionalOffset.topCenter,
                                        end: FractionalOffset.bottomCenter,
                                        stops: const [0.5, 1.0],
                                        colors: [
                                          Colors.white.withOpacity(0.0),
                                          Colors.white,
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Center(
                              child: GestureDetector(
                                onTap: () {},
                                child: Text(
                                  'READ MORE',
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(
                                        color: Colors.blue,
                                        letterSpacing: 3.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Cast',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3!
                                  .copyWith(color: Colors.black),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    height: 70,
                                    child: ListView.separated(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (_, index) =>
                                          const CircleAvatar(
                                        radius: 40,
                                      ),
                                      separatorBuilder: (_, index) =>
                                          const SizedBox(width: 16),
                                      itemCount: 5,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'Ratings - 4',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline3!
                                        .copyWith(color: Colors.black),
                                  ),
                                ),
                                Text(
                                  '${movie.rating}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline1!
                                      .copyWith(color: Colors.black),
                                ),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: SizedBox(
                                    height: 20,
                                    child: ListView.builder(
                                      primary: false,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: 5,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (_, index) => Container(
                                        margin: const EdgeInsets.only(left: 8),
                                        child: Icon(
                                          Icons.star,
                                          color: (movie.rating!.toInt() > index)
                                              ? const Color(0xFF89E045)
                                              : Colors.grey,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            // Ratings List
                            ...[
                              'Adam Noah',
                              'Paul Bohn',
                              'Andrea Zelner',
                              'Rick Sanchez',
                            ]
                                .map(
                                  (data) => ListTile(
                                    leading: const CircleAvatar(),
                                    title: Text(
                                      '$data - 12 June 2020',
                                      style:
                                          Theme.of(context).textTheme.subtitle1,
                                    ),
                                    subtitle: Row(
                                      children: [
                                        Expanded(
                                          child: SizedBox(
                                            height: 20,
                                            child: ListView.builder(
                                              primary: false,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemCount: 5,
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder: (_, index) =>
                                                  Container(
                                                margin: const EdgeInsets.only(
                                                    right: 8),
                                                child: Icon(
                                                  Icons.star,
                                                  color: (movie.rating!
                                                              .toInt() >
                                                          index)
                                                      ? const Color(0xFF89E045)
                                                      : Colors.grey,
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
                                .toList(),
                            const SizedBox(height: 32),
                            Text(
                              'You May Also Like',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3!
                                  .copyWith(color: Colors.black),
                            ),
                            const SizedBox(height: 16),
                            // Movie Card
                            Row(
                              children: [
                                Expanded(
                                  child: SizedBox(
                                      height: 206,
                                      child: Consumer<MoviesRepository>(
                                          builder: (_, repository, child) {
                                        final movies = repository
                                            .findMovies()
                                            .where((element) =>
                                                element.id != movie.id)
                                            .toList();
                                        // movies.shuffle();
                                        return ListView.separated(
                                          itemCount: movies.length,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (_, index) {
                                            final item = movies[index];
                                            return GestureDetector(
                                              onTap: () => Navigator.of(context)
                                                  .pushReplacementNamed(
                                                MovieDetailsScreen.routeName,
                                                arguments: item,
                                              ),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(6.4),
                                                child: Container(
                                                  constraints:
                                                      const BoxConstraints(
                                                    minWidth: 324,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: NetworkImage(
                                                          item.imageUrl!),
                                                      fit: BoxFit.cover,
                                                      alignment:
                                                          Alignment.center,
                                                    ),
                                                  ),
                                                  child: BackgroundGradient(
                                                    height: 200,
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 12.0),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          const SizedBox(
                                                              height: 62),
                                                          Text(
                                                            item.title!,
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .headline2!
                                                                .copyWith(
                                                                  fontSize: 20,
                                                                ),
                                                          ),
                                                          const SizedBox(
                                                              height: 12),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                item.year
                                                                    .toString(),
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyText2,
                                                              ),
                                                              const SizedBox(
                                                                  width: 12),
                                                              Text(
                                                                item.duration
                                                                    .toString(),
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyText2,
                                                              ),
                                                              const SizedBox(
                                                                  width: 12),
                                                              Text(
                                                                item.director!,
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyText2,
                                                              ),
                                                              const SizedBox(
                                                                  width: 12),
                                                            ],
                                                          ),
                                                          Row(
                                                            children: item
                                                                .genres!
                                                                .map((data) =>
                                                                    Container(
                                                                      margin: const EdgeInsets
                                                                          .only(
                                                                        right:
                                                                            8.0,
                                                                        top:
                                                                            24.0,
                                                                      ),
                                                                      padding:
                                                                          const EdgeInsets
                                                                              .symmetric(
                                                                        horizontal:
                                                                            6,
                                                                      ),
                                                                      height:
                                                                          14,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        border: Border.all(
                                                                            color:
                                                                                Colors.white),
                                                                        borderRadius:
                                                                            BorderRadius.circular(10.0),
                                                                      ),
                                                                      child:
                                                                          Text(
                                                                        data.toUpperCase(),
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .headline5!
                                                                            .copyWith(fontSize: 10),
                                                                      ),
                                                                    ))
                                                                .toList(),
                                                          ),
                                                          const SizedBox(
                                                              height: 12),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                '${item.rating}',
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .headline1!
                                                                    .copyWith(
                                                                      fontSize:
                                                                          24,
                                                                    ),
                                                              ),
                                                              const SizedBox(
                                                                  width: 6),
                                                              SizedBox(
                                                                height: 20,
                                                                child: ListView
                                                                    .separated(
                                                                  primary:
                                                                      false,
                                                                  physics:
                                                                      const NeverScrollableScrollPhysics(),
                                                                  shrinkWrap:
                                                                      true,
                                                                  itemCount: 5,
                                                                  scrollDirection:
                                                                      Axis.horizontal,
                                                                  itemBuilder:
                                                                      (_, index) =>
                                                                          Icon(
                                                                    Icons.star,
                                                                    color: (item.rating!.toInt() >
                                                                            index)
                                                                        ? const Color(
                                                                            0xFF89E045)
                                                                        : Colors
                                                                            .grey,
                                                                    size: 20,
                                                                  ),
                                                                  separatorBuilder: (_,
                                                                          __) =>
                                                                      const SizedBox(
                                                                          width:
                                                                              8),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                          separatorBuilder: (_, index) =>
                                              const SizedBox(width: 16),
                                        );
                                      })),
                                ),
                              ],
                            ),
                            // Add To Watchlist button
                            const Spacer(),
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  final hiveMovie = HiveMovie(
                                    id: movie.id,
                                    title: movie.title,
                                    overview: movie.overview,
                                    imageUrl: movie.imageUrl,
                                    director: movie.director,
                                    duration: movie.duration,
                                    rating: movie.rating,
                                    year: movie.year,
                                    genres: movie.genres,
                                  );
                                  box.containsKey(movie.id)
                                      ? box.delete(hiveMovie.id)
                                      : box.put(hiveMovie.id, hiveMovie);
                                  setState(() {
                                    movie.isWatchlist = !movie.isWatchlist;
                                  });
                                },
                                child: Ink(
                                  height: 62,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    color: !box.containsKey(movie.id)
                                        ? Colors.red
                                        : Colors.green,
                                  ),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(!box.containsKey(movie.id)
                                            ? Icons.bookmarks
                                            : Icons.remove_red_eye),
                                        const SizedBox(width: 24),
                                        Text(
                                          !box.containsKey(movie.id)
                                              ? 'Add To Watchlist'
                                              : 'Mark Watched',
                                          style: Theme.of(context)
                                              .textTheme
                                              .button,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                // Movie Poster
                Positioned(
                  left: 16,
                  top: 279,
                  child: Container(
                    height: 221,
                    width: 157,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(movie.imageUrl!),
                        fit: BoxFit.cover,
                      ),
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
                ),
                // Movie details
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    width: 200,
                    height: 200,
                    margin: const EdgeInsets.only(
                      top: 380.0,
                      right: 8.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          movie.title!,
                          style:
                              Theme.of(context).textTheme.headline2!.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              movie.year.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(color: Colors.black),
                            ),
                            // const SizedBox(width: 16),
                            Text(
                              '${(movie.duration! / 60).floor()}h ${movie.duration! % 60}min',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(color: Colors.black),
                            ),
                            // const SizedBox(width: 16),
                            Text(
                              movie.director!,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(color: Colors.black),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        FittedBox(
                          child: Row(
                            children: movie.genres!.map((data) {
                              return movie.genres!.indexOf(data) >= 3
                                  ? const SizedBox.shrink()
                                  : Container(
                                      margin: const EdgeInsets.only(right: 8),
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 2,
                                        horizontal: 8,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        border: Border.all(
                                          color: AppTheme.greenAccent,
                                        ),
                                      ),
                                      child: Text(
                                        data.toUpperCase(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5!
                                            .copyWith(
                                              color: AppTheme.greenAccent,
                                            ),
                                      ),
                                    );
                            }).toList(),
                          ),
                        )
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
