import 'package:http/http.dart' as http;
import 'package:movie_tracking/models/popular_movies.dart';
import 'dart:convert';
import '../models/movie.dart';

const String apiKey = '4deb693703mshc16c9f3d1df1b16p17ba1fjsn03b53fa79b64';
const String apiHost = 'imdb8.p.rapidapi.com';

// var unirest = require('unirest');

// var req = unirest('GET', 'https://imdb8.p.rapidapi.com/title/get-overview-details');

// req.query({
// 	'tconst': 'tt9032400/',
// 	'currentCountry': 'US'
// });

// req.headers({
// 	'x-rapidapi-key': '4deb693703mshc16c9f3d1df1b16p17ba1fjsn03b53fa79b64',
// 	'x-rapidapi-host': 'imdb8.p.rapidapi.com',
// 	'useQueryString': true
// });

// var unirest = require("unirest");

// var req = unirest("GET", "https://imdb8.p.rapidapi.com/title/get-most-popular-movies");

// req.query({
// 	"homeCountry": "US",
// 	"purchaseCountry": "US",
// 	"currentCountry": "US"
// });

// req.headers({
// 	"x-rapidapi-key": "4deb693703mshc16c9f3d1df1b16p17ba1fjsn03b53fa79b64",
// 	"x-rapidapi-host": "imdb8.p.rapidapi.com",
// 	"useQueryString": true
// });

// var req = unirest("GET", "https://imdb8.p.rapidapi.com/title/get-images");

// req.query({
// 	"tconst": "tt0944947",
// 	"limit": "25"
// });

class MovieApi {
  static Future<Movie> getDetails(String queryId) async {
    var uri = Uri.https(apiHost, '/title/get-overview-details',
        {'tconst': queryId.replaceAll('/title/', ''), 'currentCountry': 'US'});
    final response = await http.get(uri, headers: {
      'x-rapidapi-key': apiKey,
      'x-rapidapi-host': apiHost,
      'useQueryString': 'true'
    });
    var data = jsonDecode(response.body);
    print(data);
    return Movie.fromJson(data);
  }

  static Future<List<PopularMovies>> getPopularMovies() async {
    var uri = Uri.https(apiHost, '/title/get-most-popular-movies',
        {"homeCountry": "US", "purchaseCountry": "US", "currentCountry": "US"});
    final response = await http.get(uri, headers: {
      'x-rapidapi-key': apiKey,
      'x-rapidapi-host': apiHost,
      'useQueryString': 'true'
    });

    List _temp = [];
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      // print(data);
      for (var i in data) {
        _temp.add(i);
      }
      print(_temp);
    } else {
      print(response.statusCode);
    }
    return PopularMovies.moviesFromSnapshot(_temp);
  }

  // static Future<List<PopularMovies>> getImages() async {
  //   var uri = Uri.https(
  //       apiHost, '/title/get-images', {"tconst": "tt0944947", "limit": "25"});
  //   final response = await http.get(uri, headers: {
  //     'x-rapidapi-key': apiKey,
  //     'x-rapidapi-host': apiHost,
  //     'useQueryString': 'true'
  //   });

  //   List _temp = [];
  //   if (response.statusCode == 200) {
  //     Map data = jsonDecode(response.body);

  //     for (var i in data['images']) {
  //       _temp.add(i);
  //     }
  //   } else {
  //     print(response.statusCode);
  //   }
  //   return PopularMovies.imagesFromSnapshot(_temp);
  // }
}
