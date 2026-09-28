import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:news_app/Data/models/article_model.dart';
import 'package:news_app/core/constants/app_constants.dart';
import 'package:news_app/core/error/exceptions.dart';

abstract class NewsCacheDataSource {
  Future<void> cacheArticles({
    required List<ArticleModel> articles,
  });

  Future<List<ArticleModel>> getCachedArticles();

  Future<bool> hasValidCache();

  Future<void> clearCache();
}

class NewsCacheDataSourceImpl implements NewsCacheDataSource {
  //step1 --> create class's variable :
  static const String boxName = 'news_cache';
  static const String articlesKey = 'articles';
  static const String cachedAtKey = 'cached_at';
  final Box<dynamic> box;

  //step2 --> create constructor :
  const NewsCacheDataSourceImpl({
    required this.box,
  });


  //step3 --> here I will call NewsCacheDataSource functions with implements :
  //cacheArticles
  @override
  Future<void> cacheArticles({
    required List<ArticleModel> articles,
  }) async {
    try {
      final limitedArticles = articles
          .take(AppConstants.maxCachedArticles)
          .toList();

      final articlesJson = limitedArticles
          .map((article) => jsonEncode(article.toJson()))
          .toList();

      await box.put(articlesKey, articlesJson);
      await box.put(
        cachedAtKey,
        DateTime.now().toUtc().toIso8601String(),
      );
    } catch (e) {
      throw CacheException(e.toString());
    }
  }


  //getCachedArticles
  @override
  Future<List<ArticleModel>> getCachedArticles() async {
    try {
      final cachedData = box.get(articlesKey);

      if (cachedData == null) {
        return [];
      }

      if (cachedData is! List) {
        throw const CacheException('Cached news format is invalid.');
      }

      return cachedData
          .map(
            (item) => ArticleModel.fromJson(
          jsonDecode(item as String) as Map<String, dynamic>,
        ),
      )
          .toList();
    } on CacheException {
      rethrow;
    } catch (e) {
      throw CacheException(e.toString());
    }
  }


  //hasValidCache
  @override
  Future<bool> hasValidCache() async {
    try {
      final cachedAtValue = box.get(cachedAtKey);

      if (cachedAtValue == null) {
        return false;
      }

      final cachedAt = DateTime.tryParse(
        cachedAtValue.toString(),
      );

      if (cachedAt == null) {
        return false;
      }

      final difference = DateTime.now().toUtc().difference(
        cachedAt.toUtc(),
      );

      return difference <= AppConstants.newsCacheDuration;
    } catch (e) {
      throw CacheException(e.toString());
    }
  }


  //clearCache
  @override
  Future<void> clearCache() async {
    try {
      await box.clear();
    } catch (e) {
      throw CacheException(e.toString());
    }
  }
}