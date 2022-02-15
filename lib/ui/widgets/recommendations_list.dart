import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:movie_tracking/data/hive/hive_db.dart';

import '../../data/cloud_firestore/firestore_movie.dart';
import '../../models/movie.dart';
import '../../screens/movie_details_screen.dart';
import 'movie_card.dart';

class RecommendationsList extends StatelessWidget {
  const RecommendationsList({Key? key, required this.items}) : super(key: key);

  final List<QueryDocumentSnapshot<FirestoreMovie>> items;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 235,
            child: ListView.separated(
              itemCount: items.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, index) {
                final item = items[index].data().toMovie();
                item.reference = items[index].reference.id;
                return ClipRRect(
                  borderRadius: BorderRadius.circular(6.4),
                  child: MovieCard(
                    movie: item,
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        MovieDetailsScreen.routeName,
                        arguments: item,
                      );
                    },
                  ),
                );
              },
              separatorBuilder: (_, index) => const SizedBox(width: 16),
            ),
            //   },
            // ),
          ),
        ),
      ],
    );
  }
}
