import 'package:chopper/chopper.dart';

import 'model_response.dart';
import 'movie_model.dart';
import 'model_converter.dart';

part 'movie_service.chopper.dart';

const apiKey = '4deb693703mshc16c9f3d1df1b16p17ba1fjsn03b53fa79b64';
const apiHost = 'imdb8.p.rapidapi.com';
const apiUrl = 'https://imdb8.p.rapidapi.com';

@ChopperApi()
abstract class MovieService extends ChopperService {
  @Get(path: '/title/get-overview-details')
  Future<Response<Result<APIMovieQuery>>> queryMovies(
      @Query('tconst') String tconst,
      @Query('currentCountry') String currentCountry);

  static MovieService create() {
    final client = ChopperClient(
      baseUrl: apiUrl,
      interceptors: [_addQuery, HttpLoggingInterceptor()],
      converter: ModelConverter(),
      errorConverter: const JsonConverter(),
      services: [
        _$MovieService(),
      ],
    );
    return _$MovieService(client);
  }
}

Request _addQuery(Request req) {
  final headerParams = Map<String, String>.from(req.headers);
  headerParams['x-rapidapi-key'] = apiKey;
  headerParams['x-rapidapi-host'] = apiHost;
  return req.copyWith(headers: headerParams);
}
