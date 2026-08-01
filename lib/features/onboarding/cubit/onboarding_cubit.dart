import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:news_app/core/datasource/local_data/preferences_manager.dart';
import 'package:news_app/core/datasource/local_data/storage_key.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  //step1 -->> class's variables :
  final PageController pageController = PageController();

  OnboardingCubit() : super(const OnboardingState());

  //step2 -->> here I will Create a function to onPageChanged :
  void onPageChanged(int index) {
    emit(state.copyWith(currentIndex: index, isLastPage: index == 2));
  }

  //step3 -->> here I will Create a function to ElevatedButton logec:
  Future<void> onFinish() async {
    await PreferencesManager().setBool(StorageKey.onboardingComplete, true);
  }

  @override
  Future<void> close() {
    pageController.dispose();
    return super.close();
  }
}
