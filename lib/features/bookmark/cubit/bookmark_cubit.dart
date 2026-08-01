import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:news_app/core/enums/request_status_enum.dart';
import 'package:news_app/features/bookmark/model/bookmark_model.dart';
import 'package:news_app/features/bookmark/repository/bookmark_repository.dart';
import 'package:news_app/features/news/model/news.dart';

part 'bookmark_state.dart';

class BookmarkCubit extends Cubit<BookmarkState> {
  //step1 -->> class's variables :
  final BookmarkRepository repository;

  BookmarkCubit(this.repository) : super(const BookmarkState()) {
    loadBookmarks();
  }

  //step2 -->> create loda function :
  void loadBookmarks() {
    emit(state.copyWith(bookmarkStatus: RequestStatusEnum.loading));

    try {
      final bookmarks = repository.getAllBookmarks();

      emit(
        state.copyWith(
          bookmarkStatus: RequestStatusEnum.loaded,
          bookmarks: bookmarks,
          errorMessage: null,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          bookmarkStatus: RequestStatusEnum.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  //step3 -->> create toggleBookmark function :
  Future<bool> toggleBookmark(News news) async {
    try {
      final result = await repository.toggleBookmark(news);

      loadBookmarks();

      return result;
    } catch (e) {
      emit(
        state.copyWith(
          bookmarkStatus: RequestStatusEnum.error,
          errorMessage: e.toString(),
        ),
      );

      return false;
    }
  }

  //step4 -->> create removeBookmark function :
  Future<void> removeBookmark(String url) async {
    try {
      await repository.removeBookmark(url);

      loadBookmarks();
    } catch (e) {
      emit(
        state.copyWith(
          bookmarkStatus: RequestStatusEnum.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
