import 'package:dio/dio.dart';
import 'package:news_app/core/constants/api_constants.dart';


class DioClient {
  static Dio create() {
    return Dio(
      BaseOptions(
        baseUrl: ApiConstants.gNewsBaseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        sendTimeout: const Duration(seconds: 15),
        headers: {
          'Accept': 'application/json',
        },
      ),
    );
  }

  const DioClient._();
}