import 'package:flutter_news_app/models/news_api_response.dart';

abstract class NewsRepository {
  Future<NewsApiResponse?> getHeadlines() async {
    return null;
  }

  Future<NewsApiResponse?> searchNewsHeadlines(String searchQuery) async {
    return null;
  }

  Future<NewsApiResponse?> getNewsHeadlinesBasedOnCategory(
      String category) async {
    return null;
  }
}
