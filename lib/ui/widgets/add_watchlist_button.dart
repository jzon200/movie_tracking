import 'package:flutter/material.dart';
import 'package:movie_tracking/data/cloud_firestore/watchlist_dao.dart';
import 'package:provider/provider.dart';

import '../../models/movie.dart';
import '../color.dart';

class AddWatchlistButton extends StatefulWidget {
  const AddWatchlistButton({
    Key? key,
    required this.movie,
    // required this.isWatchlist,
    required this.onPressed,
    required this.isWatchlist,
  }) : super(key: key);

  final Movie movie;
  final bool isWatchlist;
  final Function() onPressed;

  @override
  State<AddWatchlistButton> createState() => _AddWatchlistButtonState();
}

class _AddWatchlistButtonState extends State<AddWatchlistButton> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: widget.onPressed,
        child: Ink(
          height: 62,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: (!widget.isWatchlist) ? blue : Colors.green,
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon((!widget.isWatchlist)
                    ? Icons.bookmarks
                    : Icons.remove_red_eye),
                const SizedBox(width: 24),
                Text(
                  (!widget.isWatchlist) ? 'Add To Watchlist' : 'Mark Watched',
                  style: Theme.of(context)
                      .textTheme
                      .headline3!
                      .copyWith(fontWeight: FontWeight.w500),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
