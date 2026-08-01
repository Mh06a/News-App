part of 'home_cubit.dart';

class HomeState extends Equatable {
  //step1 -->> class's variables :
  final RequestStatusEnum trendingStatus;
  final RequestStatusEnum topHeadlinesStatus;

  final List<News> trendingNews;
  final List<News> topHeadlines;

  final String? trendingError;
  final String? topHeadlinesError;
  final String selectedCategory;

  //step2 -->> create init function :
  const HomeState({
    this.trendingStatus = RequestStatusEnum.loading,
    this.topHeadlinesStatus = RequestStatusEnum.loading,
    this.trendingError,
    this.topHeadlinesError,
    this.trendingNews = const [],
    this.topHeadlines = const [],
    this.selectedCategory = ApiConstants.defaultCategory,
  });

  //step3 -->> create copy function :
  HomeState copyWith({
    RequestStatusEnum? trendingStatus,
    RequestStatusEnum? topHeadlinesStatus,
    List<News>? trendingNews,
    List<News>? topHeadlines,
    String? trendingError,
    String? topHeadlinesError,
    String? selectedCategory,
  }) {
    return HomeState(
      trendingStatus: trendingStatus ?? this.trendingStatus,
      topHeadlinesStatus: topHeadlinesStatus ?? this.topHeadlinesStatus,
      trendingNews: trendingNews ?? this.trendingNews,
      topHeadlines: topHeadlines ?? this.topHeadlines,
      trendingError: trendingError,
      topHeadlinesError: topHeadlinesError,
      selectedCategory: selectedCategory ?? this.selectedCategory,
    );
  }

  //step4 -->> use Equatable :
  @override
  List<Object?> get props => [
    trendingStatus,
    topHeadlinesStatus,
    trendingNews,
    topHeadlines,
    trendingError,
    topHeadlinesError,
    selectedCategory,
  ];
}
