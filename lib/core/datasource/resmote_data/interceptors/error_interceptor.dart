import 'package:dio/dio.dart';
import 'package:news_app/core/exceptions/api_exception.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    String message;

    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        message = "Connection timeout";
        break;

      case DioExceptionType.connectionError:
        message = "No internet connection";
        break;

      case DioExceptionType.badResponse:
        switch (err.response?.statusCode) {
          case 400:
            message = "Bad request";
            break;
          case 401:
            message = "Unauthorized";
            break;
          case 403:
            message = "Forbidden";
            break;
          case 404:
            message = "Resource not found";
            break;
          case 500:
            message = "Internal server error";
            break;
          default:
            message = "Server error";
        }
        break;

      case DioExceptionType.cancel:
        message = "Request cancelled";
        break;

      default:
        message = "Unexpected error";
    }

    handler.reject(
      DioException(
        requestOptions: err.requestOptions,
        error: ApiException(
          message: message,
          statusCode: err.response?.statusCode,
        ),
      ),
    );
  }
}
