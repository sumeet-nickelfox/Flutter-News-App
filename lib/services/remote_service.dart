import 'package:flutter_news_app/models/news_api_response.dart';
import 'package:http/http.dart' as http;

class RemoteService {
  // Future<NewsApiResponse?> getNewsHeadlines() async {
  //   var client = http.Client();

  //   var url = Uri.parse(
  //       'https://newsapi.org/v2/top-headlines?country=us&apiKey=020685a3862d47c383cf4a4506d5f303');
  //   var response = await client.get(url);
  //   if (response.statusCode == 200) {
  //     var json = response.body;
  //     return newsApiResponseFromJson(json);
  //   }
  //   return null;
  // }

  // Future<NewsApiResponse?> searchNewsHeadlines() async {
  //   var client = http.Client();

  //   var url = Uri.parse(
  //       'https://newsapi.org/v2/top-headlines?country=us&apiKey=020685a3862d47c383cf4a4506d5f303');
  //   var response = await client.get(url);
  //   if (response.statusCode == 200) {
  //     var json = response.body;
  //     return newsApiResponseFromJson(json);
  //   }
  // }
}
