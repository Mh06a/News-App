
import 'package:news_app/core/result/result.dart';

abstract class RecentSearchRepository {
  //step1 -->> create function to get recent searches :
  Future<Result<List<String>>> getRecentSearches();

  //step2 -->> create function to add recent search :
  Future<Result<void>> addRecentSearch({required String query});

  //step3 -->> create function to remove recent search :
  Future<Result<void>> removeRecentSearch({required String query});

  //step4 -->> create function to clear recent searches :
  Future<Result<void>> clearRecentSearches();
}