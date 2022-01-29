class PopularMovies {
  final String title;
  PopularMovies({required this.title});

  factory PopularMovies.fromJson(dynamic json) {
    return PopularMovies(
      title: json as String,
    );
  }

  static List<PopularMovies> moviesFromSnapshot(List snapshot) {
    return snapshot.map((e) => PopularMovies.fromJson(e)).toList();
  }

  static List<PopularMovies> imagesFromSnapshot(List snapshot) {
    return snapshot.map((e) => PopularMovies.fromJson(e)).toList();
  }

  @override
  String toString() {
    return 'Movie {title: $title}';
  }
}
