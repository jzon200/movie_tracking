import 'dart:convert';
import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:movie_tracking/models/movie.dart';
import 'movie_model.dart';

const String apiKey = '0d47f470dfmsh5f67790683d6b16p1824f8jsna6b5b525b404';
const String apiHost = 'imdb8.p.rapidapi.com';

class HttpService {
  Future getData(Uri uri) async {
    print('Calling uri: $uri');
    final response = await http.get(
      uri,
      headers: {
        'x-rapidapi-key': apiKey,
        'x-rapidapi-host': apiHost,
        'useQueryString': 'true',
      },
    );
    if (response.statusCode == 200) {
      print(response.body);
      return response.body;
    } else {
      print(response.statusCode);
    }
  }

  Future<Movie> getMovieDetails(
      {required String tconst, String currentCountry = 'US'}) async {
    const path = '/title/get-overview-details';
    final uri = Uri.https(apiHost, path, {
      'tconst': tconst.replaceAll('/title/', ''),
      'currentCountry': currentCountry,
    });
    final data = await getData(uri);
    return Movie.fromJson(jsonDecode(data));
  }

  Future<List<APIPopularMovies>> getPopularMovies() async {
    const path = '/title/get-most-popular-movies';
    final uri = Uri.https(apiHost, path, {
      "homeCountry": "US",
      "purchaseCountry": "US",
      "currentCountry": "US",
    });
    final data = await getData(uri);

    return parseMovies(data);
  }

  List<APIPopularMovies> parseMovies(String responseBody) {
    final parsed = jsonDecode(responseBody);
    return parsed
        .map<APIPopularMovies>((json) => APIPopularMovies.fromJson(json))
        .toList();
  }
}
