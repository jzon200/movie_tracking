import 'package:flutter/material.dart';
import 'package:movie_tracking/models/tab_provider.dart';
import 'package:provider/provider.dart';

import 'screens/main_screen.dart';
import 'ui/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark(),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => TabProvider()),
        ],
        child: const MainScreen(),
      ),
    );
  }
}
