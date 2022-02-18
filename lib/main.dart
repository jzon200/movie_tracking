import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/cloud_firestore/top_movies_dao.dart';
import 'data/cloud_firestore/trending_movies_dao.dart';
import 'data/cloud_firestore/watchlist_dao.dart';
import 'models/tab_provider.dart';
import 'screens/main_screen.dart';
import 'screens/movie_details_screen.dart';
import 'ui/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // Configure Firestore Offline Persistence
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
    // cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => TabProvider(),
        ),
        Provider(
          lazy: false,
          create: (_) => TrendingMoviesDao(),
        ),
        Provider(
          lazy: false,
          create: (_) => TopMoviesDao(),
        ),
        Provider(
          lazy: false,
          create: (_) => WatchlistDao(),
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
