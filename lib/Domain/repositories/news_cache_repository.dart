import 'package:news_app/Domain/entities/article.dart';
import 'package:news_app/core/result/result.dart';

abstract class NewsCacheRepository {
  //step1 -->> create function to get cached news :
  Future<Result<List<Article>>> getCachedNews();

  //step2 -->> create function to save news :
  Future<Result<void>> saveNews({required List<Article> articles});

  //step3 -->> create function to clear cache :
  Future<Result<void>> clearCache();

  //step4 -->> create function to is cache valid :
  Future<Result<bool>> isCacheValid();
}