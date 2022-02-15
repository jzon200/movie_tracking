import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:movie_tracking/data/cloud_firestore/watchlist_dao.dart';
import 'package:provider/provider.dart';

import 'data/cloud_firestore/movie_dao.dart';
import 'data/hive/hive_repository.dart';
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
  // FirebaseFirestore.instance
  //     .collection('watchlist')
  //     .doc('rJssbhYRQRn31b2P7d5E')
  //     .delete()
  //     .then((value) => print("User Deleted"))
  //     .catchError((error) => print("Failed to delete user: $error"));
  ;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => HiveRepository(),
        ),
        ChangeNotifierProvider(
          create: (_) => TabProvider(),
        ),
        Provider(
          lazy: false,
          create: (_) => MovieDao(),
        ),
        Provider(
          lazy: false,
          create: (_) => WatchlistDao(),
        ),
        // ChangeNotifierProvider(
        //   lazy: false,
        //   create: (_) => WatchlistRepository(),
        // ),
        // ChangeNotifierProvider(
        //   create: (_) => MoviesRepository(),
        // ),
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
