import 'package:news_app/Domain/repositories/recent_search_repository.dart';
import 'package:news_app/core/result/result.dart';

class GetRecentSearches {
  //step1 -->> class's variables :
  final RecentSearchRepository repository;


  //step2 -->> Constructor :
  const GetRecentSearches(this.repository);


  //step3 --> create function to use in presentation layer :
  Future<Result<List<String>>> call() {
    return repository.getRecentSearches();
  }
}