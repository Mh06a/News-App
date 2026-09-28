import 'package:dio/dio.dart';
import 'package:news_app/Data/models/article_model.dart';
import 'package:news_app/Data/models/news_response_model.dart';
import 'package:news_app/core/constants/api_constants.dart';
import 'package:news_app/core/error/exceptions.dart';

abstract class GNewsRemoteDataSource {
  Future<List<ArticleModel>> getTopHeadlines({
    required String country,
    required String language,
  });

  Future<List<ArticleModel>> getNewsByCategory({
    required String category,
    required String country,
    required String language,
    int page = 1 ,
  });

  Future<List<ArticleModel>> searchNews({
    required String query,
    required String country,
    required String language,
    int page = 1,
  });
}


class GNewsRemoteDataSourceImpl implements GNewsRemoteDataSource {
  //step1 -->> class's variables :
  final Dio dio;
  final String apiKey;


  //step2 -->> Constructor :
  const GNewsRemoteDataSourceImpl({
    required this.dio,
    required this.apiKey,
  });


  //step3 --> here I will call GNewsRemoteDataSource functions with implements :
  //getTopHeadlines
  @override
  Future<List<ArticleModel>> getTopHeadlines({
    required String country,
    required String language,
  }) async {
    try {
      final response = await dio.get(
        ApiConstants.topHeadlinesEndpoint,
        queryParameters: {
          'apikey': apiKey,
          'country': country,
          'lang': language,
        },
      );

      final newsResponse = NewsResponseModel.fromJson(
        response.data as Map<String, dynamic>,
      );

      return newsResponse.articles;
    } on DioException catch (e) {
      throw _handleDioException(e);
    } on FormatException catch (e) {
      throw UnknownException(e.toString());
    } catch (e) {
      throw UnknownException(e.toString());
    }
  }

  //getNewsByCategory
  @override
  Future<List<ArticleModel>> getNewsByCategory({
    required String category,
    required String country,
    required String language,
    int page = 1 ,
  }) async {
    try {
      final response = await dio.get(
        ApiConstants.topHeadlinesEndpoint,
        queryParameters: {
          'apikey': apiKey,
          'category': category,
          'country': country,
          'lang': language,
          'page': page
        },
      );

      final newsResponse = NewsResponseModel.fromJson(
        response.data as Map<String, dynamic>,
      );

      return newsResponse.articles;
    } on DioException catch (e) {
      throw _handleDioException(e);
    } on FormatException catch (e) {
      throw UnknownException(e.toString());
    } catch (e) {
      throw UnknownException(e.toString());
    }
  }


  //searchNews
  @override
  Future<List<ArticleModel>> searchNews({
    required String query,
    required String country,
    required String language,
    int page = 1,
  }) async {
    try {
      final response = await dio.get(
        ApiConstants.searchEndpoint,
        queryParameters: {
          'apikey': apiKey,
          'q': query,
          'country': country,
          'lang': language,
          'page': page,
        },
      );

      final newsResponse = NewsResponseModel.fromJson(
        response.data as Map<String, dynamic>,
      );

      return newsResponse.articles;
    } on DioException catch (e) {
      throw _handleDioException(e);
    } on FormatException catch (e) {
      throw UnknownException(e.toString());
    } catch (e) {
      throw UnknownException(e.toString());
    }
  }

  Exception _handleDioException(DioException exception) {
    switch (exception.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        return NetworkException(
          exception.message ?? 'Network error occurred.',
        );

      case DioExceptionType.badResponse:
        final statusCode = exception.response?.statusCode;

        if (statusCode == 401 || statusCode == 403) {
          return ServerException(
            exception.response?.data?['errors']?.toString() ??
                'Unauthorized request.',
          );
        }

        if (statusCode != null && statusCode >= 500) {
          return ServerException(
            'Server error occurred.',
          );
        }

        return ServerException(
          exception.response?.data?['errors']?.toString() ??
              'Request failed.',
        );

      default:
        return UnknownException(
          exception.message ?? 'Unknown error occurred.',
        );
    }
  }
}