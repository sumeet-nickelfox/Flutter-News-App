import 'package:flutter/material.dart';
import 'package:flutter_news_app/ui/bottom_nav_bar.dart';

class BookmarkedScreen extends StatelessWidget {
  const BookmarkedScreen({Key? key}) : super(key: key);

  static const routeName = '/bookmarked';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookmarked Headlines'),
        automaticallyImplyLeading: false,
      ),
      bottomNavigationBar: const BottomNavBar(index: 2),
      body: const Center(child: Text('Feature not yet implemented')),
    );
  }
}
