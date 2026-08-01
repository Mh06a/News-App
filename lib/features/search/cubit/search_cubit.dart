import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:news_app/core/enums/request_status_enum.dart';
import 'package:news_app/features/news/controller/news_controller.dart';
import 'package:news_app/features/news/model/news.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  //step1 -->> class's variables :
  final NewsController controller;

  SearchCubit(this.controller) : super(SearchState());

  //step2 -->> getEverything function :
  Future<void> loadGetEverything({required String query}) async {
    emit(
      state.copyWith(
        everythingStatus: RequestStatusEnum.loading,
        errorMessage: null,
      ),
    );

    try {
      final news = await controller.getEverything(query: query);
      if (isClosed) return;

      emit(
        state.copyWith(
          everythingStatus: RequestStatusEnum.loaded,
          newsEverythingList: news,
          errorMessage: null,
        ),
      );
    } catch (e) {
      if (isClosed) return;
      emit(
        state.copyWith(
          everythingStatus: RequestStatusEnum.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
