import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiClient {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'https://api.spoonacular.com/',
    connectTimeout: Duration(seconds: 10),
    receiveTimeout: Duration(seconds: 10),
  ));

  ApiClient() {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        options.queryParameters['apiKey'] = dotenv.env['SPOONACULAR_API_KEY'];
        return handler.next(options);
      },
    ));
  }

  Dio get dio => _dio;
}
