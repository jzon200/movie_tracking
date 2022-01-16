import 'package:flutter/material.dart';
import 'package:movie_tracking/models/movie.dart';

class TrendingScreen extends StatelessWidget {
  const TrendingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: Movie.movieInfo.length,
      itemBuilder: (_, index) {
        final movie = Movie.movieInfo[index];
        return Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              isAntiAlias: true,
              image: AssetImage(movie.imageUrl),
              fit: BoxFit.cover,
              alignment: (movie.id == 'm2' || movie.id == 'm6')
                  ? const Alignment(0.0, -0.75)
                  : Alignment.center,
            ),
            gradient: LinearGradient(
              begin: FractionalOffset.topCenter,
              end: FractionalOffset.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.08),
                Colors.black,
              ],
            ),
          ),
          child: Container(
            height: 263,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: FractionalOffset.topCenter,
                end: FractionalOffset.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.08),
                  Colors.black,
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 79),
                  Text(
                    movie.title,
                    style: Theme.of(context).textTheme.headline2,
                    softWrap: false,
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Text(
                        movie.date.year.toString(),
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        movie.duration,
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
                  Row(
                    children: movie.genre
                        .map(
                          (data) => Container(
                            margin: const EdgeInsets.only(
                              right: 8.0,
                              top: 30.0,
                            ),
                            padding: const EdgeInsets.symmetric(
                              vertical: 2,
                              horizontal: 8,
                            ),
                            height: 20,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Text(
                              data.toUpperCase(),
                              style: Theme.of(context).textTheme.headline5,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Text(
                        '${movie.rating}',
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: SizedBox(
                          height: 20,
                          child: ListView.separated(
                            primary: false,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: 5,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (_, index) => Icon(
                              Icons.star,
                              color: (movie.rating.toInt() > index)
                                  ? const Color(0xFF89E045)
                                  : Colors.grey,
                              size: 20,
                            ),
                            separatorBuilder: (_, __) =>
                                const SizedBox(width: 8),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
