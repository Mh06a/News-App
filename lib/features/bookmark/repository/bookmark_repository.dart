import 'package:news_app/core/datasource/local_data/hive_manager.dart';
import 'package:news_app/features/bookmark/model/bookmark_model.dart';
import 'package:news_app/features/news/model/news.dart';
import 'package:news_app/features/user/repository/user_repository.dart';

class BookmarkRepository {
  BookmarkRepository._internal();
  static final BookmarkRepository _instance = BookmarkRepository._internal();
  factory BookmarkRepository() => _instance;

  final HiveManager _manager = HiveManager();
  final UserRepository _userRepository = UserRepository();

  String get _userId {
    final user = _userRepository.getCurrentUser();

    if (user == null) {
      throw Exception("No logged in user");
    }

    return user.userId;
  }

  String _key(String url) => "${_userId}_$url";

  List<BookmarkModel> getAllBookmarks() {
    final box = _manager.bookmarksBox;

    return box.values.where((bookmark) => bookmark.userId == _userId).toList();
  }

  Future<void> addBookmark(BookmarkModel bookmark) async {
    await _manager.bookmarksBox.put(_key(bookmark.url), bookmark);
  }

  Future<void> removeBookmark(String url) async {
    await _manager.bookmarksBox.delete(_key(url));
  }

  bool isBookmarked(String url) {
    return _manager.bookmarksBox.containsKey(_key(url));
  }

  Future<void> clearBookmarks() async {
    final box = _manager.bookmarksBox;

    final keys = box.keys.where(
      (key) => key.toString().startsWith("${_userId}_"),
    );

    await box.deleteAll(keys);
  }

  News bookmarkToNews(BookmarkModel bookmark) {
    return News(
      author: bookmark.author,
      title: bookmark.title,
      description: bookmark.description,
      url: bookmark.url,
      urlToImage: bookmark.urlToImage,
      publishedAt: bookmark.publishedAt,
      content: bookmark.description,
    );
  }

  Future<bool> toggleBookmark(News news) async {
    if (isBookmarked(news.url)) {
      await removeBookmark(news.url);
      return false;
    }

    final bookmark = BookmarkModel(
      userId: _userId,
      url: news.url,
      author: news.author,
      title: news.title,
      description: news.description,
      urlToImage: news.urlToImage,
      publishedAt: news.publishedAt,
    );

    await addBookmark(bookmark);

    return true;
  }
}
