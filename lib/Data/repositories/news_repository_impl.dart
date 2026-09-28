import 'package:news_app/Data/dataSource/local/news_cache_data_source.dart';
import 'package:news_app/Data/dataSource/remote/gnews_remote_data_source.dart';
import 'package:news_app/Data/models/article_model.dart';
import 'package:news_app/Domain/repositories/news_repository.dart';
import 'package:news_app/core/error/failure.dart';
import 'package:news_app/core/error/exceptions.dart';
import 'package:news_app/core/network/network_info.dart';
import 'package:news_app/core/result/result.dart';

class NewsRepositoryImpl implements NewsRepository {
  //step1 --> create class's variable :
  final GNewsRemoteDataSource remoteDataSource;
  final NewsCacheDataSource cacheDataSource;
  final NetworkInfo networkInfo;


  //step2 -->> Constructor :
  const NewsRepositoryImpl({
    required this.remoteDataSource,
    required this.cacheDataSource,
    required this.networkInfo,
  });


  //step3 --> here I will call NewsRepository functions with implements :
  //-----getTopHeadlines-----
  @override
  Future<Result<List<ArticleModel>>> getTopHeadlines({
    required String country,
    required String language,
  }) async {
    final isConnected = await networkInfo.isConnected;

    if (!isConnected) {
      return _getCachedNews();
    }

    try {
      final articles = await remoteDataSource.getTopHeadlines(
        country: country,
        language: language,
      );

      await cacheDataSource.cacheArticles(
        articles: articles,
      );

      return Success(articles);
    } on NetworkException catch (e) {
      return FailureResult(
        NetworkFailure(e.message),
      );
    } on ServerException catch (e) {
      return FailureResult(
        ServerFailure(e.message),
      );
    } on UnknownException catch (e) {
      return FailureResult(
        UnknownFailure(e.message),
      );
    }
  }


  //-----getNewsByCategory-----
  @override
  Future<Result<List<ArticleModel>>> getNewsByCategory({
    required String category,
    required String country,
    required String language,
    int page = 1
  }) async {
    final isConnected = await networkInfo.isConnected;

    if (!isConnected) {
      return _getCachedNews();
    }

    try {
      final articles = await remoteDataSource.getNewsByCategory(
        category: category,
        country: country,
        language: language,
        page: page
      );

      return Success(articles);
    } on NetworkException catch (e) {
      return FailureResult(
        NetworkFailure(e.message),
      );
    } on ServerException catch (e) {
      return FailureResult(
        ServerFailure(e.message),
      );
    } on UnknownException catch (e) {
      return FailureResult(
        UnknownFailure(e.message),
      );
    }
  }


  //-----searchNews-----
  @override
  Future<Result<List<ArticleModel>>> searchNews({
    required String query,
    required String country,
    required String language,
    int page = 1,
  }) async {
    final isConnected = await networkInfo.isConnected;

    if (!isConnected) {
      return const FailureResult(
        NetworkFailure(
          'Internet connection is required to search for news.',
        ),
      );
    }

    try {
      final articles = await remoteDataSource.searchNews(
        query: query,
        country: country,
        language: language,
        page: page,
      );

      return Success(articles);
    } on NetworkException catch (e) {
      return FailureResult(
        NetworkFailure(e.message),
      );
    } on ServerException catch (e) {
      return FailureResult(
        ServerFailure(e.message),
      );
    } on UnknownException catch (e) {
      return FailureResult(
        UnknownFailure(e.message),
      );
    }
  }

  //-----_getCachedNews-----
  Future<Result<List<ArticleModel>>> _getCachedNews() async {
    try {
      final isValid = await cacheDataSource.hasValidCache();

      if (!isValid) {
        return const FailureResult(
          CacheFailure(
            'No valid cached news available.',
          ),
        );
      }

      final articles = await cacheDataSource.getCachedArticles();

      if (articles.isEmpty) {
        return const FailureResult(
          CacheFailure(
            'No cached news available.',
          ),
        );
      }

      return Success(articles);
    } on CacheException catch (e) {
      return FailureResult(
        CacheFailure(e.message),
      );
    } on UnknownException catch (e) {
      return FailureResult(
        UnknownFailure(e.message),
      );
    }
  }
}