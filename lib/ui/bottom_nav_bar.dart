import 'package:flutter/material.dart';
import 'package:flutter_news_app/ui/bookmarked_screen.dart';
import 'package:flutter_news_app/ui/home_screen.dart';
import 'package:flutter_news_app/ui/search_screen.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: index,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.black.withAlpha(100),
      items: [
        BottomNavigationBarItem(
            icon: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, HomeScreen.routeName);
                },
                icon: const Icon(Icons.home)),
            label: 'Home'),
        BottomNavigationBarItem(
            icon: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, SearchScreen.routeName);
                },
                icon: const Icon(Icons.search)),
            label: 'Search'),
        BottomNavigationBarItem(
            icon: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, BookmarkedScreen.routeName);
                },
                icon: const Icon(Icons.bookmark)),
            label: 'Bookmarked'),
      ],
    );
  }
}
