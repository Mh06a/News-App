import 'package:news_app/Data/dataSource/local/recent_search_data_source.dart';
import 'package:news_app/Domain/repositories/recent_search_repository.dart';
import 'package:news_app/core/error/exceptions.dart';
import 'package:news_app/core/error/failure.dart';
import 'package:news_app/core/result/result.dart';

class RecentSearchRepositoryImpl implements RecentSearchRepository {
  //step1 --> create class's variable :
  final RecentSearchDataSource localDataSource;

  //step2 -->> Constructor :
  const RecentSearchRepositoryImpl({
    required this.localDataSource,
  });


  //step3 --> here I will call UserRepository functions with implements :
  //-----getRecentSearches-----
  @override
  Future<Result<List<String>>> getRecentSearches() async {
    try {
      final searches =
      await localDataSource.getRecentSearches();

      return Success(searches);
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


  //-----addRecentSearch-----
  @override
  Future<Result<void>> addRecentSearch({
    required String query,
  }) async {
    try {
      await localDataSource.addRecentSearch(
        query: query,
      );

      return const Success(null);
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


  //-----removeRecentSearch-----
  @override
  Future<Result<void>> removeRecentSearch({
    required String query,
  }) async {
    try {
      await localDataSource.removeRecentSearch(
        query: query,
      );

      return const Success(null);
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


  //-----clearRecentSearches-----
  @override
  Future<Result<void>> clearRecentSearches() async {
    try {
      await localDataSource.clearRecentSearches();

      return const Success(null);
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