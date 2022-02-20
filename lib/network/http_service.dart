import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/movie.dart';

const String apiKey = 'c8c0f12f10mshec5d6f9d2fc388ap17b882jsnd60af66bfa5f';
const String apiHost = 'imdb8.p.rapidapi.com';

class HttpService {
  Future getData(Uri uri) async {
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
      return;
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
    final responseBody = jsonDecode(data);
    return Movie.fromJson(responseBody);
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
        .take(10)
        .map<String>((titleId) => titleId.toString())
        .toList();
  }

  Future<List<String>> getTopMovies() async {
    const path = '/title/get-top-rated-movies';
    final uri = Uri.https(apiHost, path);
    final data = await getData(uri);
    final parsedMovies = jsonDecode(data);
    return parsedMovies
        .map<String>((json) => json['id'].toString())
        .take(10)
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

    return (parsedBio['image'] == null)
        ? null
        : (parsedBio['image']['url'] as String?);
    // return parsedMovies;
  }

  Future<List<String?>> getActorsProfile({required String tconst}) async {
    final topCast = await HttpService().getTopCast(tconst: tconst);
    final actorsProfilePic = <String?>[];
    for (var name in topCast) {
      final imageUrl = await getActorProfileUrl(nconst: name);
      actorsProfilePic.add(imageUrl);
    }
    return actorsProfilePic;
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
}
