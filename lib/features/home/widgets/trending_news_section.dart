import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/constants/app_sizes.dart';
import 'package:news_app/core/enums/request_status_enum.dart';
import 'package:news_app/core/themes/app_colors.dart';
import 'package:news_app/features/home/cubit/home_cubit.dart';
import 'package:news_app/features/home/widgets/trending_news_card.dart';
import 'package:news_app/features/home/widgets/trending_news_shimmer.dart';
import 'package:news_app/features/home/widgets/view_all_component.dart';

class TrendingNews extends StatelessWidget {
  const TrendingNews({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: AppSizes.h310,
        child: Stack(
          children: [
            SizedBox(
              width: double.infinity,
              height: AppSizes.h240,
              child: Image.asset(
                "assets/images/home_background.png",
                fit: BoxFit.cover,
              ),
            ),

            Positioned(
              top: AppSizes.h70,
              right: 0,
              left: 0,
              child: Column(
                children: [
                  Text(
                    "NEWST",
                    style: TextStyle(
                      fontSize: AppSizes.font40,
                      color: AppColors.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  ViewAllComponent(
                    title: "Trending News",
                    titleColor: AppColors.textOnPrimary,
                    onTap: () {},
                  ),

                  SizedBox(height: AppSizes.h12),

                  BlocBuilder<HomeCubit, HomeState>(
                    builder: (context, state) {
                      switch (state.trendingStatus) {
                        case RequestStatusEnum.loading:
                          return const TrendingNewsShimmer();

                        case RequestStatusEnum.error:
                          return SizedBox(
                            height: AppSizes.h140,
                            child: Center(
                              child: Text(
                                state.trendingError ?? "Unknown Error",
                              ),
                            ),
                          );

                        case RequestStatusEnum.loaded:
                          return SizedBox(
                            height: AppSizes.h140,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: state.trendingNews.take(6).length,
                              itemBuilder: (context, index) {
                                return TrendingNewsCard(
                                  news: state.trendingNews[index],
                                );
                              },
                            ),
                          );
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
