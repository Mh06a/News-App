import 'package:news_app/Data/models/bookmark_model.dart';
import 'package:news_app/Domain/entities/article.dart';
import 'package:news_app/core/error/exceptions.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthException;

abstract class SupabaseBookmarkDataSource {
  Future<List<BookmarkModel>> getBookmarks();

  Future<BookmarkModel> addBookmark({
    required Article article,
  });

  Future<void> removeBookmark({
    required String articleId,
  });

  Future<bool> isBookmarked({
    required String articleId,
  });
}



class SupabaseBookmarkDataSourceImpl implements SupabaseBookmarkDataSource {
  //step1 -->> class's variables :
  final SupabaseClient supabase;


  //step2 -->> Constructor :
  const SupabaseBookmarkDataSourceImpl({
    required this.supabase,
  });


  //step3 --> here I will call SupabaseBookmarkDataSource functions with implements:
  //getBookmarks
  @override
  Future<List<BookmarkModel>> getBookmarks() async {
    try {
      final user = supabase.auth.currentUser;

      if (user == null) {
        throw const AuthException(
          'User is not authenticated.',
        );
      }

      final response = await supabase
          .from('bookmarks')
          .select()
          .eq('user_id', user.id)
          .order(
        'created_at',
        ascending: false,
      );

      return response
          .map<BookmarkModel>(
            (json) => BookmarkModel.fromJson(
          Map<String, dynamic>.from(json),
        ),
      )
          .toList();
    } on AuthException {
      rethrow;
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw UnknownException(e.toString());
    }
  }


  //addBookmark
  @override
  Future<BookmarkModel> addBookmark({
    required Article article,
  }) async {
    try {
      final user = supabase.auth.currentUser;

      if (user == null) {
        throw const AuthException(
          'User is not authenticated.',
        );
      }

      final response = await supabase
          .from('bookmarks')
          .insert({
        'user_id': user.id,
        'article_id': article.id,
        'title': article.title,
        'description': article.description,
        'content': article.content,
        'image': article.image,
        'url': article.url,
        'published_at':
        article.publishedAt?.toIso8601String(),
        'language': article.language,
        'source_id': article.source.id,
        'source_name': article.source.name,
        'source_url': article.source.url,
        'source_country': article.source.country,
      })
          .select()
          .single();

      return BookmarkModel.fromJson(
        Map<String, dynamic>.from(response),
      );
    } on AuthException {
      rethrow;
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw UnknownException(e.toString());
    }
  }


  //removeBookmark
  @override
  Future<void> removeBookmark({
    required String articleId,
  }) async {
    try {
      final user = supabase.auth.currentUser;

      if (user == null) {
        throw const AuthException(
          'User is not authenticated.',
        );
      }

      await supabase
          .from('bookmarks')
          .delete()
          .eq('user_id', user.id)
          .eq('article_id', articleId);
    } on AuthException {
      rethrow;
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw UnknownException(e.toString());
    }
  }


  //isBookmarked
  @override
  Future<bool> isBookmarked({
    required String articleId,
  }) async {
    try {
      final user = supabase.auth.currentUser;

      if (user == null) {
        throw const AuthException(
          'User is not authenticated.',
        );
      }

      final response = await supabase
          .from('bookmarks')
          .select('id')
          .eq('user_id', user.id)
          .eq('article_id', articleId)
          .maybeSingle();

      return response != null;
    } on AuthException {
      rethrow;
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw UnknownException(e.toString());
    }
  }
}