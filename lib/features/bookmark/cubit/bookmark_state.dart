part of 'bookmark_cubit.dart';

class BookmarkState extends Equatable {
  //step1 -->> class's variables :
  final RequestStatusEnum bookmarkStatus;
  final List<BookmarkModel> bookmarks;
  final String? errorMessage;

  //step2 -->> Constructor :
  const BookmarkState({
    this.bookmarkStatus = RequestStatusEnum.loading,
    this.bookmarks = const [],
    this.errorMessage,
  });

  //step3 -->> create copy function :
  BookmarkState copyWith({
    RequestStatusEnum? bookmarkStatus,
    List<BookmarkModel>? bookmarks,
    String? errorMessage,
  }) {
    return BookmarkState(
      bookmarkStatus: bookmarkStatus ?? this.bookmarkStatus,
      bookmarks: bookmarks ?? this.bookmarks,
      errorMessage: errorMessage,
    );
  }

  //step4 -->> use Equatable :
  @override
  List<Object?> get props => [bookmarkStatus, bookmarks, errorMessage];
}
