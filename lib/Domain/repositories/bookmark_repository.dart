import 'package:news_app/Domain/entities/article.dart';
import 'package:news_app/Domain/entities/bookmark.dart';
import 'package:news_app/core/result/result.dart';

abstract class BookmarkRepository {
  //step1 -->> create function to get bookmarks :
  Future<Result<List<Bookmark>>> getBookmarks();


  //step2 -->> create function to add bookmark :
  Future<Result<void>> addBookmark(Article article);


  //step3 -->> create function to remove bookmark :
  Future<Result<void>> removeBookmark(String articleId);


  //step4 -->> create function to check is bookmarked :
  Future<Result<bool>> isBookmarked(String articleId);
}