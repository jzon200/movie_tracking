import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../models/movie.dart';
import '../color.dart';
import 'background_gradient.dart';
import 'genre_chip.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({
    Key? key,
    required this.movie,
    this.onTap,
  }) : super(key: key);

  final Movie movie;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final deviceHeight = deviceSize.height;
    return GestureDetector(
        onTap: onTap,
        child: CachedNetworkImage(
          imageUrl: movie.imageUrl ?? '',
          placeholder: (context, url) => Container(
            color: materialThemeDark,
            height: deviceHeight * 0.35,
            width: 324,
            child: Center(
              child: SpinKitThreeBounce(
                color: gray,
                size: deviceHeight * 0.05,
              ),
            ),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
          imageBuilder: (context, imageProvider) => Container(
            constraints: BoxConstraints(
              minHeight: deviceSize.height * 0.35,
              minWidth: 324,
            ),
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
                    AutoSizeText(
                      movie.title ?? '',
                      minFontSize: 16,
                      maxFontSize: 24,
                      maxLines: 2,
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    Wrap(
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
                        if (movie.director != null)
                          Text(
                            movie.director!,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                      ],
                    ),
                    Wrap(
                      spacing: 8.0,
                      children: movie.genres!
                          .take(3)
                          .map((data) => GenreChip(text: data))
                          .toList(),
                    ),
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
                            style: Theme.of(context).textTheme.headline2,
                          ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
