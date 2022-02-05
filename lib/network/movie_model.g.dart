// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

APIMovieQuery _$APIMovieQueryFromJson(Map<String, dynamic> json) =>
    APIMovieQuery(
      id: json['id'] as String,
      title: APITitle.fromJson(json['title'] as Map<String, dynamic>),
      ratings: APIRatings.fromJson(json['ratings'] as Map<String, dynamic>),
      plotOutline:
          APIPlotOutline.fromJson(json['plotOutline'] as Map<String, dynamic>),
      genres: json['genres'] as List<dynamic>,
    );

Map<String, dynamic> _$APIMovieQueryToJson(APIMovieQuery instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'ratings': instance.ratings,
      'plotOutline': instance.plotOutline,
      'genres': instance.genres,
    };

APIRatings _$APIRatingsFromJson(Map<String, dynamic> json) => APIRatings(
      rating: (json['rating'] as num).toDouble(),
    );

Map<String, dynamic> _$APIRatingsToJson(APIRatings instance) =>
    <String, dynamic>{
      'rating': instance.rating,
    };

APIPlotOutline _$APIPlotOutlineFromJson(Map<String, dynamic> json) =>
    APIPlotOutline(
      text: json['text'] as String,
    );

Map<String, dynamic> _$APIPlotOutlineToJson(APIPlotOutline instance) =>
    <String, dynamic>{
      'text': instance.text,
    };

APITitle _$APITitleFromJson(Map<String, dynamic> json) => APITitle(
      title: json['title'] as String,
      image: APIImage.fromJson(json['image'] as Map<String, dynamic>),
      duration: json['runningInMinutes'] as int,
      year: json['year'] as int,
    );

Map<String, dynamic> _$APITitleToJson(APITitle instance) => <String, dynamic>{
      'title': instance.title,
      'image': instance.image,
      'runningInMinutes': instance.duration,
      'year': instance.year,
    };

APIImage _$APIImageFromJson(Map<String, dynamic> json) => APIImage(
      url: json['url'] as String,
    );

Map<String, dynamic> _$APIImageToJson(APIImage instance) => <String, dynamic>{
      'url': instance.url,
    };
