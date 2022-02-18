import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  /// Builds centered [CircularProgressIndicator]
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
