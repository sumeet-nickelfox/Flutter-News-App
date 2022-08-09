import 'package:flutter_news_app/data/remote/network/api_end_points.dart';
import 'package:flutter_news_app/data/remote/network/base_api_service.dart';
import 'package:flutter_news_app/data/remote/network/network_api_service.dart';
import 'package:flutter_news_app/models/news_api_response.dart';
import 'package:flutter_news_app/repository/news_repostitory.dart';
import 'dart:developer' as developer;

class NewsRepositoryImp implements NewsRepository {
  final BaseApiService _apiService = NetworkApiService();

  final apiKey = '020685a3862d47c383cf4a4506d5f303';

  @override
  Future<NewsApiResponse?> getHeadlines() async {
    try {
      final queryParameters = {
        'apiKey': apiKey,
        'country': 'in',
      };
      dynamic response = await _apiService.getResponse(
          ApiEndPoints().getHeadlines, queryParameters);
      final jsonData = NewsApiResponse.fromJson(response);
      return jsonData;
    } catch (e) {
      developer.log("NewsRepository = $e");
      rethrow;
    }
  }

  @override
  Future<NewsApiResponse?> searchNewsHeadlines(String searchQuery) async {
    try {
      final queryParameters = {
        'apiKey': apiKey,
        'q': searchQuery,
      };
      dynamic response = await _apiService.getResponse(
          ApiEndPoints().searchHeadlines, queryParameters);
      final jsonData = NewsApiResponse.fromJson(response);
      return jsonData;
    } catch (e) {
      developer.log("NewsRepository = $e");
      rethrow;
    }
  }

  @override
  Future<NewsApiResponse?> getNewsHeadlinesBasedOnCategory(
      String category) async {
    try {
      final queryParameters = {
        'apiKey': apiKey,
        'category': category,
      };
      dynamic response = await _apiService.getResponse(
          ApiEndPoints().getHeadlines, queryParameters);
      final jsonData = NewsApiResponse.fromJson(response);
      return jsonData;
    } catch (e) {
      developer.log("NewsRepository = $e");
      rethrow;
    }
  }
}
