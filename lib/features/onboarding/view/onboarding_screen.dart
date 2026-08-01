import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/constants/app_sizes.dart';
import 'package:news_app/core/themes/app_colors.dart';
import 'package:news_app/features/auth/view/login_screen.dart';
import 'package:news_app/features/onboarding/cubit/onboarding_cubit.dart';
import 'package:news_app/features/onboarding/model/onboarding.dart';
import 'package:news_app/shared/custom_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// ignore: must_be_immutable
class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  // here I will Create to onFinish :
  _onFinish(BuildContext context) async {
    await context.read<OnboardingCubit>().onFinish();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnboardingCubit(),
      child: Builder(
        builder: (context) {
          final state2 = context.read<OnboardingCubit>();
          return Scaffold(
            appBar: AppBar(
              actions: [
                BlocBuilder<OnboardingCubit, OnboardingState>(
                  builder: (context, state) {
                    return state.isLastPage
                        ? SizedBox()
                        : TextButton(
                            onPressed: () {
                              _onFinish(context);
                            },
                            child: Text(
                              "Skip",
                              style: TextStyle(
                                fontSize: AppSizes.font15,
                                color: AppColors.primary,
                              ),
                            ),
                          );
                  },
                ),
              ],
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(
                vertical: AppSizes.h30,
                horizontal: AppSizes.w16,
              ),
              child: Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                      controller: state2.pageController,
                      itemCount: Onboarding.onboardingList.length,
                      onPageChanged: (int index) {
                        context.read<OnboardingCubit>().onPageChanged(index);
                      },
                      itemBuilder: (context, index) {
                        final Onboarding model =
                            Onboarding.onboardingList[index];
                        return Column(
                          children: [
                            Image.asset(model.image),

                            SizedBox(height: AppSizes.h24),
                            Text(
                              model.title,
                              style: TextStyle(
                                color: Color(0xFF4E4B66),
                                fontSize: AppSizes.font20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),

                            SizedBox(height: AppSizes.h12),
                            Text(
                              model.description,
                              style: TextStyle(
                                color: Color(0xFF6E7191),
                                fontSize: AppSizes.font16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),

                  BlocBuilder<OnboardingCubit, OnboardingState>(
                    builder: (context, state) {
                      return SmoothPageIndicator(
                        controller: context
                            .read<OnboardingCubit>()
                            .pageController, // PageController
                        count: 3,
                        effect: SwapEffect(
                          activeDotColor: AppColors.primaryDark,
                        ),
                      );
                    },
                  ),

                  SizedBox(height: AppSizes.h100),
                  BlocBuilder<OnboardingCubit, OnboardingState>(
                    builder: (context, state) {
                      return CustomButton(
                        onPressed: () {
                          if (!state.isLastPage) {
                            state2.pageController.nextPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          } else {
                            _onFinish(context);
                          }
                        },

                        buttonText: state.isLastPage ? "Get Started" : "Next",
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
