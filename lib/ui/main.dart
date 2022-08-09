import 'package:flutter/material.dart';
import 'package:flutter_news_app/models/news_api_response.dart';
import 'screens.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'News 24',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        HomeScreen.routeName: (context) => const HomeScreen(),
        SearchScreen.routeName: (context) => const SearchScreen(),
        BookmarkedScreen.routeName: (context) => const BookmarkedScreen(),
        NewsArticleScreen.routeName: (context) => NewsArticleScreen(
            ModalRoute.of(context)!.settings.arguments as Articles)
      },
    );
  }
}
