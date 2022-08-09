abstract class BaseApiService {
  final String baseUrl = "newsapi.org";

  Future<dynamic> getResponse(String url, Map<String, String> queryParams);
}
