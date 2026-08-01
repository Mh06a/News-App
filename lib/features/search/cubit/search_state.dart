part of 'search_cubit.dart';

class SearchState extends Equatable {
  //step1 -->> class's variables :
  final List<News> newsEverythingList;
  final RequestStatusEnum everythingStatus;
  final String? errorMessage;

  //step2 -->> Constructor :
  const SearchState({
    this.newsEverythingList = const [],
    this.everythingStatus = RequestStatusEnum.loading,
    this.errorMessage,
  });

  //stwp3 -->> create copy function
  SearchState copyWith({
    List<News>? newsEverythingList,
    RequestStatusEnum? everythingStatus,
    String? errorMessage,
  }) {
    return SearchState(
      newsEverythingList: newsEverythingList ?? this.newsEverythingList,
      everythingStatus: everythingStatus ?? this.everythingStatus,
      errorMessage: errorMessage,
    );
  }

  //step4 -->> use Equatable
  @override
  List<Object?> get props => [
    newsEverythingList,
    everythingStatus,
    errorMessage,
  ];
}
