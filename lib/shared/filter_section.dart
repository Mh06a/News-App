import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/constants/api_constants.dart';
import 'package:news_app/core/constants/app_sizes.dart';
import 'package:news_app/core/themes/app_colors.dart';
import 'package:news_app/features/home/cubit/home_cubit.dart';

class Filtersection extends StatelessWidget {
  const Filtersection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.only(
            left: AppSizes.w16,
            top: AppSizes.h16,
            bottom: AppSizes.h16,
          ),
          child: SizedBox(
            height: AppSizes.h30,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: ApiConstants.categories.length,
              padding: EdgeInsets.only(right: AppSizes.w16),
              itemBuilder: (context, index) {
                final category = ApiConstants.categories[index];
                final isSelected = state.selectedCategory == category;
                return IntrinsicWidth(
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          context.read<HomeCubit>().changeCategory(category);
                        },
                        child: Text(
                          ApiConstants.categories[index][0].toUpperCase() +
                              ApiConstants.categories[index].substring(1),
                          style: TextStyle(
                            color: isSelected
                                ? AppColors.primary
                                : AppColors.textThirdColor,
                            fontSize: AppSizes.font16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),

                      if (isSelected) ...[
                        SizedBox(height: AppSizes.h4),
                        Container(
                          height: AppSizes.h2,
                          color: AppColors.primary,
                        ),
                      ],
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(width: AppSizes.w12);
              },
            ),
          ),
        );
      },
    );
  }
}
