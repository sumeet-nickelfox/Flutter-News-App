import 'package:flutter/foundation.dart';
import 'package:flutter_news_app/data/remote/response/api_response.dart';
import 'package:flutter_news_app/models/news_api_response.dart';
import 'package:flutter_news_app/repository/news_repository_imp.dart';
import 'package:flutter_news_app/repository/news_repostitory.dart';

class HeadlinesResponseViewModel extends ChangeNotifier {
  final NewsRepository _newsRepostiory = NewsRepositoryImp();

  ApiResponse<NewsApiResponse> newsApiResponse = ApiResponse.loading();

  void _setNewsApiResponse(ApiResponse<NewsApiResponse> response) {
    newsApiResponse = response;
    notifyListeners();
  }

  Future<void> fetchHeadlines() async {
    _setNewsApiResponse(ApiResponse.loading());
    _newsRepostiory
        .getHeadlines()
        .then((value) => _setNewsApiResponse(ApiResponse.completed(value)))
        .onError((error, stackTrace) =>
            _setNewsApiResponse(ApiResponse.error(error.toString())));
  }

  ApiResponse<NewsApiResponse> searchResponse = ApiResponse.loading();

  void _setSearchedNewsApiResponse(ApiResponse<NewsApiResponse> response) {
    searchResponse = response;
    notifyListeners();
  }

  Future<void> searchHeadlines(String searchQuery) async {
    _setSearchedNewsApiResponse(ApiResponse.loading());
    _newsRepostiory
        .searchNewsHeadlines(searchQuery)
        .then((value) =>
            _setSearchedNewsApiResponse(ApiResponse.completed(value)))
        .onError((error, stackTrace) =>
            _setSearchedNewsApiResponse(ApiResponse.error(error.toString())));
  }
}
