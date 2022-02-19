import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/tab_provider.dart';
import '../ui/color.dart';
import 'top_rated_screen.dart';
import 'trending_screen.dart';
import 'watchlist_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    const List<Widget> _pages = [
      TrendingScreen(),
      TopRatedScreen(),
      WatchListScreen(),
    ];
    return Consumer<TabProvider>(
      builder: (_, tabProvider, Widget? __) {
        return Scaffold(
          backgroundColor: darkGray,
          body: SafeArea(
            child: IndexedStack(
              index: tabProvider.selectedIndex,
              children: _pages,
            ),
          ),
          bottomNavigationBar: NavigationBarTheme(
            data: Theme.of(context).navigationBarTheme,
            child: NavigationBar(
              onDestinationSelected: tabProvider.goToTab,
              selectedIndex: tabProvider.selectedIndex,
              destinations: const [
                NavigationDestination(
                  icon: Icon(
                    Icons.whatshot_outlined,
                    color: Color(0xFFCAC4D0),
                  ),
                  selectedIcon: Icon(
                    Icons.whatshot,
                    color: Color(0xFFE8DEF8),
                  ),
                  label: 'Trending',
                  tooltip: '',
                ),
                NavigationDestination(
                  icon: Icon(
                    Icons.local_activity_outlined,
                    color: Color(0xFFCAC4D0),
                  ),
                  selectedIcon: Icon(
                    Icons.local_activity,
                    color: Color(0xFFE8DEF8),
                  ),
                  label: 'Top Rated',
                  tooltip: '',
                ),
                NavigationDestination(
                  icon: Icon(
                    Icons.bookmarks_outlined,
                    color: Color(0xFFCAC4D0),
                  ),
                  selectedIcon: Icon(
                    Icons.bookmarks,
                    color: Color(0xFFE8DEF8),
                  ),
                  label: 'Watchlist',
                  tooltip: '',
                ),
              ],
            ),
          ),
          // bottomNavigationBar: BottomNavigationBar(

          //   currentIndex: tab.selectedIndex,
          //   onTap: tab.goToTab,
          //   items: const [
          //     BottomNavigationBarItem(
          //       icon: Icon(Icons.bar_chart),
          //       label: 'Trending',
          //     ),
          //     BottomNavigationBarItem(
          //       icon: Icon(Icons.star),
          //       label: 'Top Rated',
          //     ),
          //     BottomNavigationBarItem(
          //       icon: Icon(Icons.bookmarks),
          //       label: 'Watchlist',
          //     ),
          //   ],
          // ),
        );
      },
    );
  }
}
