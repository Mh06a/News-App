import 'package:dio/dio.dart';
import 'package:news_app/core/constants/api_constants.dart';

class ApiKeyInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.queryParameters["apiKey"] = ApiConstants.apiKey;

    handler.next(options);
  }
}
