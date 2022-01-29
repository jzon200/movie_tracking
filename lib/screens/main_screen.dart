import 'package:flutter/material.dart';
import 'package:movie_tracking/network/movie_api.dart';
import '../models/tab_provider.dart';
import 'top_rated_screen.dart';
import 'trending_screen.dart';
import 'watchlist_screen.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  static const List<Widget> _pages = [
    TrendingScreen(),
    TopRatedScreen(),
    WatchListScreen(),
  ];

  // bool isLoading = true;
  // // late List movieDetails;

  // @override
  // void initState() {
  //   super.initState();
  //   getPopularMovies();
  // }

  // Future<void> getDetails() async {
  //   final movieDetails = await MovieApi.getDetails();
  //   setState(() {
  //     isLoading = false;
  //   });
  //   print(movieDetails);
  // }

  // Future<void> getPopularMovies() async {
  //   final popularMovies = await MovieApi.getPopularMovies();
  //   final details = await MovieApi.getDetails(popularMovies[0].title);
  //   setState(() {
  //     isLoading = false;
  //   });
  //   print(popularMovies);
  //   print(details);
  // }

  // Future<void> getImages() async {
  //   final images = await MovieApi.getImages();
  //   setState(() {
  //     isLoading = false;
  //   });
  //   print(images);
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer<TabProvider>(
      builder: (_, tabProvider, Widget? __) {
        return Scaffold(
          body: SafeArea(
            child: IndexedStack(
              index: tabProvider.selectedIndex,
              children: _pages,
            ),
          ),
          bottomNavigationBar: NavigationBar(
            onDestinationSelected: tabProvider.goToTab,
            selectedIndex: tabProvider.selectedIndex,
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.whatshot_outlined),
                selectedIcon: Icon(Icons.whatshot),
                label: 'Trending',
                tooltip: '',
              ),
              NavigationDestination(
                icon: Icon(Icons.local_activity_outlined),
                selectedIcon: Icon(Icons.local_activity),
                label: 'Top Rated',
                tooltip: '',
              ),
              NavigationDestination(
                icon: Icon(Icons.bookmarks_outlined),
                selectedIcon: Icon(Icons.bookmarks),
                label: 'Watchlist',
                tooltip: '',
              ),
            ],
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
