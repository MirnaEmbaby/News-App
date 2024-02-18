import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;

  //https://newsapi.org/s/egypt-news-api
  //e706c9b0e34548b6bbb748504062a6ec

  //https://newsapi.org/
  // v2/top-headlines
  // ?country=us&category=business&apiKey=e706c9b0e34548b6bbb748504062a6ec

  static init() {
    dio = Dio(BaseOptions(
      baseUrl: 'https://newsapi.org/',
      receiveDataWhenStatusError: true,
    ));
  }

  static Future<Response> getData({
    required String url,
    required Map<String, dynamic> query,
  }) async {
    return await dio!.get(
      url,
      queryParameters: query,
    );
  }
}
