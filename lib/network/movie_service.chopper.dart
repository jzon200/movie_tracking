// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations, unnecessary_brace_in_string_interps
class _$MovieService extends MovieService {
  _$MovieService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = MovieService;

  @override
  Future<Response<Result<APIMovieQuery>>> queryMovies(
      String tconst, String currentCountry) {
    final $url = '/title/get-overview-details';
    final $params = <String, dynamic>{
      'tconst': tconst,
      'currentCountry': currentCountry
    };
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<Result<APIMovieQuery>, APIMovieQuery>($request);
  }
}
