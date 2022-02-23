import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../data/cloud_firestore/firestore_movie.dart';
import 'movie_card.dart';

class RecommendationsList extends StatelessWidget {
  final List<QueryDocumentSnapshot<FirestoreMovie>> items;

  const RecommendationsList({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    items.shuffle();
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 235,
            child: ListView.separated(
              cacheExtent: 1024,
              itemCount: items.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, index) {
                final movie = items[index].data().toMovie();
                movie.documentId = items[index].reference.id;
                return ClipRRect(
                  borderRadius: BorderRadius.circular(6.4),
                  child: MovieCard(
                    movie: movie,
                  ),
                );
              },
              separatorBuilder: (_, index) => const SizedBox(width: 16),
            ),
          ),
        ),
      ],
    );
  }
}
