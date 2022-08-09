import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_news_app/data/remote/app_exception.dart';
import 'package:flutter_news_app/data/remote/network/base_api_service.dart';

class NetworkApiService extends BaseApiService {
  @override
  Future getResponse(String url, Map<String, String> queryParams) async {
    dynamic responseJson;
    try {
      final uri = Uri.https(baseUrl, url, queryParams);
      final response = await http.get(uri, headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      });
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 404:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while communication with server with status code : ${response.statusCode}');
    }
  }
}
