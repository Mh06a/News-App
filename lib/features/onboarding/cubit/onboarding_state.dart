part of 'onboarding_cubit.dart';

class OnboardingState extends Equatable {
  //step1 -->> class's variables :
  final int currentIndex;
  final bool isLastPage;

  //step2 -->> con:
  const OnboardingState({this.currentIndex = 0, this.isLastPage = false});

  //step3 -->> create copy function :
  OnboardingState copyWith({int? currentIndex, bool? isLastPage}) {
    return OnboardingState(
      currentIndex: currentIndex ?? this.currentIndex,
      isLastPage: isLastPage ?? this.isLastPage,
    );
  }

  //step4 -->> use Equatable :
  @override
  List<Object> get props => [currentIndex, isLastPage];
}
