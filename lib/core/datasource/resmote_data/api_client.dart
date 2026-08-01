import 'package:dio/dio.dart';
import 'package:news_app/core/datasource/resmote_data/dio_service.dart';

class ApiClient {
  final Dio _dio = DioService.instance.dio;

  Future<Map<String, dynamic>> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    final response = await _dio.get(path, queryParameters: queryParameters);

    return response.data as Map<String, dynamic>;
  }
}
