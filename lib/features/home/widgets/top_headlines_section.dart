import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/constants/app_sizes.dart';
import 'package:news_app/core/enums/request_status_enum.dart';
import 'package:news_app/core/themes/app_colors.dart';
import 'package:news_app/features/home/cubit/home_cubit.dart';
import 'package:news_app/features/home/view/categories_screen.dart';
import 'package:news_app/features/home/widgets/top_headlines_card.dart';
import 'package:news_app/features/home/widgets/top_headlines_shimmer.dart';
import 'package:news_app/features/home/widgets/view_all_component.dart';

class TopHeadlinesSection extends StatelessWidget {
  const TopHeadlinesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        switch (state.topHeadlinesStatus) {
          case RequestStatusEnum.loading:
            return SliverToBoxAdapter(child: TopHeadlinesShimmer());

          case RequestStatusEnum.error:
            return SliverToBoxAdapter(
              child: SizedBox(
                height: AppSizes.h150,
                child: Center(
                  child: Text(state.topHeadlinesError ?? "Unknown Error"),
                ),
              ),
            );

          case RequestStatusEnum.loaded:
            return SliverList(
              delegate: SliverChildListDelegate([
                ViewAllComponent(
                  title: "Categories",
                  titleColor: AppColors.textThirdColor,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) {
                          return BlocProvider.value(
                            value: context.read<HomeCubit>(),
                            child: CategoriesScreen(),
                          );
                        },
                      ),
                    );
                  },
                ),

                ...state.topHeadlines.map(
                  (news) => TopHeadlinesCard(news: news),
                ),
              ]),
            );
        }
      },
    );
  }
}
