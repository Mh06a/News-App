import 'package:news_app/Domain/entities/article.dart';
import 'package:news_app/core/result/result.dart';

abstract class NewsRepository {
  //step1 -->> create function to get top headlines :
  Future<Result<List<Article>>> getTopHeadlines({
    required String country,
    required String language,
  });


  //step2 -->> create function to get news by category :
  Future<Result<List<Article>>> getNewsByCategory({
    required String category,
    required String country,
    required String language,
  });


  //step3 -->> create function to search news :
  Future<Result<List<Article>>> searchNews({
    required String query,
    required String country,
    required String language,
    int page = 1,
  });
}