import 'package:dio/dio.dart';
import 'package:news_app/core/constants/api_constants.dart';
import 'package:news_app/core/datasource/resmote_data/interceptors/api_key_interceptor.dart';
import 'package:news_app/core/datasource/resmote_data/interceptors/error_interceptor.dart';
import 'package:news_app/core/datasource/resmote_data/interceptors/logger_interceptor.dart';

class DioService {
  DioService._();

  static final DioService instance = DioService._();

  late final Dio dio =
      Dio(
          BaseOptions(
            baseUrl: ApiConstants.baseUrl,
            connectTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 10),
            responseType: ResponseType.json,
            headers: {Headers.acceptHeader: 'application/json'},
          ),
        )
        ..interceptors.add(ApiKeyInterceptor())
        ..interceptors.add(LoggerInterceptor())
        ..interceptors.add(ErrorInterceptor());
}
