import 'package:news_app/core/constants/app_constants.dart';
import 'package:news_app/core/constants/storage_constants.dart';
import 'package:news_app/core/storage/local_storage.dart';

abstract class RecentSearchDataSource {
  Future<List<String>> getRecentSearches();

  Future<void> addRecentSearch({
    required String query,
  });

  Future<void> removeRecentSearch({
    required String query,
  });

  Future<void> clearRecentSearches();
}

class RecentSearchDataSourceImpl implements RecentSearchDataSource {
  //step1 --> create class's variable :
  final LocalStorage localStorage;


  //step2 --> create constructor :
  const RecentSearchDataSourceImpl({
    required this.localStorage,
  });


  //step3 --> here I will call RecentSearchDataSource functions with implements:
  //getRecentSearches
  @override
  Future<List<String>> getRecentSearches() async {
    return localStorage.getStringList(
      StorageConstants.recentSearches,
    ) ??
        [];
  }

  //addRecentSearch
  @override
  Future<void> addRecentSearch({
    required String query,
  }) async {
    final normalizedQuery = query.trim();

    if (normalizedQuery.isEmpty) {
      return;
    }

    final searches = await getRecentSearches();

    searches.removeWhere(
          (item) => item.toLowerCase() == normalizedQuery.toLowerCase(),
    );

    searches.insert(0, normalizedQuery);

    if (searches.length > AppConstants.maxRecentSearches) {
      searches.removeRange(
        AppConstants.maxRecentSearches,
        searches.length,
      );
    }

    await localStorage.setStringList(
      StorageConstants.recentSearches,
      searches,
    );
  }


  //removeRecentSearch
  @override
  Future<void> removeRecentSearch({
    required String query,
  }) async {
    final searches = await getRecentSearches();

    searches.removeWhere(
          (item) => item.toLowerCase() == query.trim().toLowerCase(),
    );

    await localStorage.setStringList(
      StorageConstants.recentSearches,
      searches,
    );
  }


  //clearRecentSearches
  @override
  Future<void> clearRecentSearches() async {
    await localStorage.remove(
      StorageConstants.recentSearches,
    );
  }
}