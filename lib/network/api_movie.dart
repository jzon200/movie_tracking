class ApiMovie {
  final String id;
  final String title;
  final String overview;
  final String imageUrl;
  final int duration;
  final double rating;
  final int year;
  final List genres;

  ApiMovie({
    required this.id,
    required this.title,
    required this.overview,
    required this.imageUrl,
    required this.duration,
    required this.rating,
    required this.year,
    required this.genres,
  });

  factory ApiMovie.fromJson(Map<String, dynamic> json) {
    return ApiMovie(
      id: json['id'] as String,
      title: json['title']['title'] as String,
      overview: json['plotOutline']['text'] as String,
      imageUrl: json['title']['image']['url'] as String,
      duration: json['title']['runningTimeInMinutes'] as int,
      rating: json['ratings']['rating'] ?? 0.0,
      year: json['title']['year'] as int,
      genres: json['genres'] as List,
    );
  }
}
