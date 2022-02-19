import 'package:flutter/material.dart';

class GenreChip extends StatelessWidget {
  final String text;

  const GenreChip({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        text,
        style: Theme.of(context).textTheme.headline5,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      side: const BorderSide(color: Color(0xFF938F99)),
      backgroundColor: const Color(0xFF1C1B1F),
    );
  }
}
