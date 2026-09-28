import 'package:news_app/Data/dataSource/remote/supabase_bookmark_data_source.dart';
import 'package:news_app/core/error/exceptions.dart';
import 'package:news_app/core/error/failure.dart';
import 'package:news_app/core/network/network_info.dart';
import 'package:news_app/core/result/result.dart';
import 'package:news_app/Domain/entities/bookmark.dart';
import 'package:news_app/Domain/entities/article.dart';
import 'package:news_app/Domain/repositories/bookmark_repository.dart';

class BookmarkRepositoryImpl implements BookmarkRepository {
  //step1 --> create class's variable :
  final SupabaseBookmarkDataSource remoteDataSource;
  final NetworkInfo networkInfo;


  //step2 -->> Constructor :
  const BookmarkRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });


  //step3 --> here I will call AuthRepository functions with implements :
  //-----getBookmarks-----
  @override
  Future<Result<List<Bookmark>>> getBookmarks() async {
    final isConnected = await networkInfo.isConnected;

    if (!isConnected) {
      return const FailureResult(
        NetworkFailure(
          'Internet connection is required to view saved stories.',
        ),
      );
    }

    try {
      final bookmarks = await remoteDataSource.getBookmarks();

      return Success(bookmarks);
    } on AuthException catch (e) {
      return FailureResult(AuthFailure(e.message));
    } on ServerException catch (e) {
      return FailureResult(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return FailureResult(NetworkFailure(e.message));
    } on UnknownException catch (e) {
      return FailureResult(UnknownFailure(e.message));
    }
  }


  //-----addBookmark-----
  @override
  Future<Result<void>> addBookmark(Article article) async {
    final isConnected = await networkInfo.isConnected;

    if (!isConnected) {
      return const FailureResult(
        NetworkFailure(
          'Internet connection is required to save an article.',
        ),
      );
    }

    try {
      await remoteDataSource.addBookmark(
        article: article,
      );

      return const Success(null);
    } on AuthException catch (e) {
      return FailureResult(AuthFailure(e.message));
    } on ServerException catch (e) {
      return FailureResult(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return FailureResult(NetworkFailure(e.message));
    } on UnknownException catch (e) {
      return FailureResult(UnknownFailure(e.message));
    }
  }


  //-----removeBookmark-----
  @override
  Future<Result<void>> removeBookmark(String articleId) async {
    final isConnected = await networkInfo.isConnected;

    if (!isConnected) {
      return const FailureResult(
        NetworkFailure(
          'Internet connection is required to remove a saved article.',
        ),
      );
    }

    try {
      await remoteDataSource.removeBookmark(
        articleId: articleId,
      );

      return const Success(null);
    } on AuthException catch (e) {
      return FailureResult(AuthFailure(e.message));
    } on ServerException catch (e) {
      return FailureResult(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return FailureResult(NetworkFailure(e.message));
    } on UnknownException catch (e) {
      return FailureResult(UnknownFailure(e.message));
    }
  }


  //-----isBookmarked-----
  @override
  Future<Result<bool>> isBookmarked(String articleId) async {
    final isConnected = await networkInfo.isConnected;

    if (!isConnected) {
      return const FailureResult(
        NetworkFailure(
          'Internet connection is required to check saved articles.',
        ),
      );
    }

    try {
      final result = await remoteDataSource.isBookmarked(
        articleId: articleId,
      );

      return Success(result);
    } on AuthException catch (e) {
      return FailureResult(AuthFailure(e.message));
    } on ServerException catch (e) {
      return FailureResult(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return FailureResult(NetworkFailure(e.message));
    } on UnknownException catch (e) {
      return FailureResult(UnknownFailure(e.message));
    }
  }
}