import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:news_app/core/constants/api_constants.dart';
import 'package:news_app/core/datasource/resmote_data/api_client.dart';
import 'package:news_app/core/enums/request_status_enum.dart';
import 'package:news_app/features/news/controller/news_controller.dart';
import 'package:news_app/features/news/model/news.dart';
import 'package:news_app/features/news/repository/news_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  //step1 -->> class's variables :
  final NewsController controller = NewsController(NewsRepository(ApiClient()));

  HomeCubit() : super(const HomeState()) {
    loadGetEverything(query: "technology");

    loadTopHeadlines(country: "us", category: state.selectedCategory);
  }

  //step3 -->> getEverything function :
  Future<void> loadGetEverything({required String query}) async {
    emit(
      state.copyWith(
        trendingStatus: RequestStatusEnum.loading,
        trendingError: null,
      ),
    );

    try {
      final news = await controller.getEverything(query: query);
      if (isClosed) return;

      emit(
        state.copyWith(
          trendingStatus: RequestStatusEnum.loaded,
          trendingNews: news,
          trendingError: null,
        ),
      );
    } catch (e) {
      if (isClosed) return;
      emit(
        state.copyWith(
          trendingStatus: RequestStatusEnum.error,
          trendingError: e.toString(),
        ),
      );
    }
  }

  //step4 -->> getTopHeadlines function :
  Future<void> loadTopHeadlines({
    required String country,
    String? category,
  }) async {
    emit(
      state.copyWith(
        topHeadlinesStatus: RequestStatusEnum.loading,
        topHeadlinesError: null,
      ),
    );

    try {
      final news = await controller.getTopHeadlines(
        country: country,
        category: category,
      );

      if (isClosed) return;

      emit(
        state.copyWith(
          topHeadlinesStatus: RequestStatusEnum.loaded,
          topHeadlines: news,
          topHeadlinesError: null,
        ),
      );
    } catch (e) {
      if (isClosed) return;
      emit(
        state.copyWith(
          topHeadlinesStatus: RequestStatusEnum.error,
          topHeadlinesError: e.toString(),
        ),
      );
    }
  }

  //step5 -->> change Category

  Future<void> changeCategory(String category) async {
    emit(state.copyWith(selectedCategory: category));

    await loadTopHeadlines(country: "us", category: category);
  }
}
