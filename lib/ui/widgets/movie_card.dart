import 'package:flutter/material.dart';

import '../../models/movie.dart';
import 'background_gradient.dart';

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
    return GestureDetector(
      onTap: onTap,
      child: Container(
        constraints: const BoxConstraints(minHeight: 263),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(movie.imageUrl),
            fit: BoxFit.cover,
            alignment: (movie.id == 'm2' || movie.id == 'm6')
                ? const Alignment(0.0, -0.75)
                : Alignment.center,
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
                    movie.title,
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
                      '${(movie.duration / 60).floor()}h ${movie.duration % 60}min',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      movie.director,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    const SizedBox(width: 12),
                  ],
                ),
                // const SizedBox(height: 30),
                Wrap(
                  spacing: 8.0,
                  children: movie.genres.map((data) {
                    return movie.genres.indexOf(data) >= 3
                        ? const SizedBox.shrink()
                        : Container(
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
                          );
                  }).toList(),
                ),
                // const SizedBox(height: 16),
                Row(
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
                          final rating = (movie.rating / 2);
                          return Icon(
                            Icons.star,
                            color: (rating.toInt() > index)
                                ? const Color(0xFF89E045)
                                : Colors.grey,
                            size: 20,
                          );
                        },
                        separatorBuilder: (_, __) => const SizedBox(width: 8),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
