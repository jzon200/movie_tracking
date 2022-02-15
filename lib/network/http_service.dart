import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/cast.dart';
import '../models/movie.dart';

const String apiKey = '3699168e6emsh75b0c25459f56fap1f024bjsn54ddb5a2e809';
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

  Future<List<String>> getPopularMovies() async {
    const path = '/title/get-most-popular-movies';
    final uri = Uri.https(apiHost, path, {
      "homeCountry": "US",
      "purchaseCountry": "US",
      "currentCountry": "US",
    });
    final data = await getData(uri);
    final parsedMovies = jsonDecode(data);
    return parsedMovies
        .take(5)
        .map<String>((titleId) => titleId.toString())
        .toList();
  }

  Future<List<String>> getTopMovies() async {
    const path = '/title/get-top-rated-movies';
    final uri = Uri.https(apiHost, path);
    final data = await getData(uri);
    final parsedMovies = jsonDecode(data);
    return parsedMovies
        .map<String>((titleId) => titleId.toString())
        .take(5)
        .toList();
  }

  Future<List<String>> getTopCast({required String tconst}) async {
    const path = '/title/get-top-cast';
    final uri = Uri.https(apiHost, path, {
      'tconst': tconst.replaceAll('/title/', ''),
    });
    final data = await getData(uri);
    final parsedMovies = jsonDecode(data);
    return parsedMovies
        .map<String>((movie) => movie.toString())
        .take(5)
        .toList();
  }

  Future<String?> getActorProfileUrl({required String nconst}) async {
    const path = '/actors/get-bio';
    final uri = Uri.https(apiHost, path, {
      'nconst': nconst.replaceAll('/name/', ''),
    });
    final data = await getData(uri);
    final parsedBio = jsonDecode(data);
    return (parsedBio['image']['url'] as String?);
    // return parsedMovies;
  }

  Future<String> getDirector({required String tconst}) async {
    const path = '/title/get-top-crew';
    final uri = Uri.https(apiHost, path, {
      'tconst': tconst.replaceAll('/title/', ''),
    });
    final data = await getData(uri);
    final parsedData = jsonDecode(data);
    return (parsedData['directors'][0]['name']);
  }

  // List<APIPopularMovies> parseMovies(String responseBody) {
  //   final parsed = jsonDecode(responseBody);
  // return parsed
  //     .take(5)
  //     .map<APIPopularMovies>((json) => APIPopularMovies.fromJson(json))
  //     .toList();
  // }
}
