import 'package:news_app/Domain/repositories/recent_search_repository.dart';
import 'package:news_app/core/result/result.dart';

class RemoveRecentSearch {
  //step1 -->> class's variables :
  final RecentSearchRepository repository;


  //step2 -->> Constructor :
  const RemoveRecentSearch(this.repository);


  //step3 --> create function to use in presentation layer :
  Future<Result<void>> call({
    required String query,
  }) {
    return repository.removeRecentSearch(
      query: query,
    );
  }
}