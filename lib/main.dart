import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:logging/logging.dart';
import 'package:movie_tracking/data/hive/hive_repository.dart';
import 'package:movie_tracking/data/repository.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:provider/provider.dart';

import 'data/hive/hive_db.dart';
import 'data/movies_repository.dart';
import 'data/watchlist_repository.dart';
import 'models/tab_provider.dart';
import 'screens/main_screen.dart';
import 'screens/movie_details_screen.dart';
import 'ui/app_theme.dart';

Future<void> main() async {
  _setupLogging();
  WidgetsFlutterBinding.ensureInitialized();
  // final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  // Hive.init(appDocumentDir.path);
  // final repository = HiveRepository();
  // repository.init();
  await Hive.initFlutter();
  Hive.registerAdapter(HiveMovieAdapter());
  await Hive.openBox<HiveMovie>('movies');
  // final box = Hive.box<HiveMovie>('movies');
  // box.clear();
  runApp(const MyApp());
}

void _setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });
}

class MyApp extends StatelessWidget {
  // final Repository repository;
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Provider<Repository>(
        //   lazy: false,
        //   create: (_) => repository,
        //   dispose: (_, repository) => repository.close(),
        // ),
        ChangeNotifierProvider(create: (_) => TabProvider()),
        ChangeNotifierProvider(
          lazy: false,
          create: (_) => WatchlistRepository(),
        ),
        ChangeNotifierProvider(
          create: (_) => MoviesRepository(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.dark(),
        home: const MainScreen(),
        routes: {
          MovieDetailsScreen.routeName: (context) => const MovieDetailsScreen(),
        },
      ),
    );
  }
}
