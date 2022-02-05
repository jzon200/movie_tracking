import 'package:movie_tracking/network/movie_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import '../../models/movie.dart';
import 'package:sqlbrite/sqlbrite.dart';
import 'package:synchronized/synchronized.dart';

class DatabaseHelper {
  static const _databaseName = 'MyWatchlist.db';
  static const _databaseVersion = 1;

  static const movieTable = 'Movie';
  static const movieId = 'movieId';

  static late BriteDatabase _streamDatabase;

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static var lock = Lock();

  static Database? _database;

  Future _onCreate(Database db, int version) async {
    await db.execute('''
        CREATE TABLE $movieTable (
          $movieId INTEGER PRIMARY KEY,
          title TEXT,
          overView TEXT,
          imageUrl TEXT,
          director TEXT,
          duration INTEGER,
          year INTEGER,
          rating REAL,
        )
        ''');
  }

  // this opens the database (and creates it if it doesn't exist)
  Future<Database> _initDatabase() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = p.join(documentsDirectory.path, _databaseName);

    // TODO: Remember to turn off debugging before deploying app to store(s).
    Sqflite.setDebugModeOn(true);
    return openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    await lock.synchronized(() async {
      if (_database == null) {
        _database = await _initDatabase();
        _streamDatabase = BriteDatabase(_database!);
      }
    });
    return _database!;
  }

  Future<BriteDatabase> get streamDatabase async {
    await database;
    return _streamDatabase;
  }

  List<Movie> parseMovies(List<Map<String, dynamic>> movieList) {
    final movies = <Movie>[];
    for (var recipeMap in movieList) {
      final recipe = Movie.fromJson(recipeMap);
      movies.add(recipe);
    }
    return movies;
  }

  Future<List<Movie>> findAllMovies() async {
    final db = await instance.streamDatabase;
    final movieList = await db.query(movieTable);
    final movies = parseMovies(movieList);
    return movies;
  }

  Stream<List<Movie>> watchAllMovies() async* {
    final db = await instance.streamDatabase;
    yield* db.createQuery(movieTable).mapToList((row) => Movie.fromJson(row));
  }

  Future<int> insert(String table, Map<String, dynamic> row) async {
    final db = await instance.streamDatabase;
    return db.insert(table, row);
  }

  Future<int> insertMovies(APIMovieQuery movie) {
    return insert(movieTable, movie.toJson());
  }

  Future<int> _delete(String table, String columnId, String id) async {
    final db = await instance.streamDatabase;
    return db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> deleteMovie(Movie movie) async {
    if (movie.id != null) {
      return _delete(movieTable, movieId, movie.id!);
    } else {
      return Future.value(-1);
    }
  }

  void close() {
    _streamDatabase.close();
  }
}
