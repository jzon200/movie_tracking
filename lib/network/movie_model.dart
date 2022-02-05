import 'package:json_annotation/json_annotation.dart';

part 'movie_model.g.dart';

class APIPopularMovies {
  final String title;
  APIPopularMovies({required this.title});

  factory APIPopularMovies.fromJson(dynamic json) {
    return APIPopularMovies(title: json as String);
  }

  List<APIPopularMovies> moviesFromSnapshot(List snapshot) {
    return snapshot.map((e) => APIPopularMovies.fromJson(e)).toList();
  }
}

@JsonSerializable()
class APIMovieQuery {
  factory APIMovieQuery.fromJson(Map<String, dynamic> json) =>
      _$APIMovieQueryFromJson(json);

  Map<String, dynamic> toJson() => _$APIMovieQueryToJson(this);

  String id;
  APITitle title;
  APIRatings ratings;
  APIPlotOutline plotOutline;
  List genres;

  APIMovieQuery({
    required this.id,
    required this.title,
    required this.ratings,
    required this.plotOutline,
    required this.genres,
  });
}

@JsonSerializable()
class APIRatings {
  factory APIRatings.fromJson(Map<String, dynamic> json) =>
      _$APIRatingsFromJson(json);
  Map<String, dynamic> toJson() => _$APIRatingsToJson(this);

  double rating;
  APIRatings({required this.rating});
}

@JsonSerializable()
class APIPlotOutline {
  factory APIPlotOutline.fromJson(Map<String, dynamic> json) =>
      _$APIPlotOutlineFromJson(json);

  Map<String, dynamic> toJson() => _$APIPlotOutlineToJson(this);

  String text;
  APIPlotOutline({required this.text});
}

@JsonSerializable()
class APITitle {
  factory APITitle.fromJson(Map<String, dynamic> json) =>
      _$APITitleFromJson(json);

  Map<String, dynamic> toJson() => _$APITitleToJson(this);

  String title;
  APIImage image;
  @JsonKey(name: 'runningInMinutes')
  int duration;
  int year;

  APITitle({
    required this.title,
    required this.image,
    required this.duration,
    required this.year,
  });
}

@JsonSerializable()
class APIImage {
  factory APIImage.fromJson(Map<String, dynamic> json) =>
      _$APIImageFromJson(json);
  Map<String, dynamic> toJson() => _$APIImageToJson(this);

  String url;
  APIImage({required this.url});
}
