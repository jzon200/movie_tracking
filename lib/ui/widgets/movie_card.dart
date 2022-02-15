import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:movie_tracking/ui/color.dart';

import '../../data/cloud_firestore/firestore_movie.dart';
import '../../models/movie.dart';
import 'background_gradient.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({
    Key? key,
    required this.movie,
    this.onTap,
    // required this.reference,
  }) : super(key: key);

  final Movie movie;
  final Function()? onTap;
  // final DocumentReference<FirestoreMovie> reference;

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final deviceHeight = deviceSize.height;
    // final deviceWidth = deviceSize.width;
    // print(deviceSize);
    // final size = MediaQuery.of(context).size.height * 0.35;
    return GestureDetector(
        onTap: onTap,
        child: CachedNetworkImage(
          imageUrl: movie.imageUrl ?? '',
          placeholder: (context, url) => SizedBox(
            height: deviceHeight * 0.35,
            width: 324,
            child: Center(
              child: SpinKitThreeBounce(
                color: Colors.grey,
                size: deviceHeight * 0.05,
              ),
            ),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
          imageBuilder: (context, imageProvider) => Container(
            constraints: BoxConstraints(
                minHeight: deviceSize.height * 0.35, minWidth: 324),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
                alignment: const Alignment(0, -0.5),
              ),
            ),
            child: BackgroundGradient(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 12.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    FittedBox(
                      child: Text(
                        movie.title ?? '',
                        style: Theme.of(context).textTheme.headline2,
                      ),
                    ),
                    // const SizedBox(height: 24),
                    Row(
                      children: [
                        Text(
                          movie.year.toString(),
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          '${(movie.duration! / 60).floor()}h ${movie.duration! % 60}min',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        const SizedBox(width: 12),
                        if (movie.director != null)
                          Text(
                            movie.director!,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        const SizedBox(width: 12),
                      ],
                    ),
                    // const SizedBox(height: 30),
                    Wrap(
                      spacing: 8.0,
                      children: movie.genres!
                          .take(3)
                          .map((data) => Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 2,
                                  horizontal: 8,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Text(
                                  data.toUpperCase(),
                                  style: Theme.of(context).textTheme.headline5,
                                ),
                              ))
                          .toList(),
                    ),
                    // const SizedBox(height: 16),
                    (movie.rating != null)
                        ? Row(
                            children: [
                              Text(
                                '${movie.rating}',
                                style: Theme.of(context).textTheme.headline1,
                              ),
                              const SizedBox(width: 6),
                              SizedBox(
                                height: 20,
                                child: ListView.separated(
                                  primary: false,
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: 5,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (_, index) {
                                    final rating = (movie.rating! / 2);
                                    return Icon(
                                      Icons.star,
                                      color: (rating.toInt() > index)
                                          ? yellow
                                          : Colors.grey,
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
                            style: Theme.of(context).textTheme.headline1,
                          ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
