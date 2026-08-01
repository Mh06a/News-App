import 'package:flutter/material.dart';
import 'package:news_app/core/constants/app_sizes.dart';
import 'package:shimmer/shimmer.dart';

class TopHeadlinesShimmer extends StatelessWidget {
  const TopHeadlinesShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(6, (index) {
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.w16,
            vertical: AppSizes.h8,
          ),
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Row(
              children: [
                Container(
                  width: AppSizes.w130,
                  height: AppSizes.h75,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(AppSizes.r12),
                  ),
                ),

                SizedBox(width: AppSizes.w10),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: AppSizes.h14,
                        width: double.infinity,
                        color: Colors.white,
                      ),

                      SizedBox(height: AppSizes.h8),

                      Container(
                        height: AppSizes.h14,
                        width: AppSizes.w180,
                        color: Colors.white,
                      ),

                      SizedBox(height: AppSizes.h12),

                      Row(
                        children: [
                          CircleAvatar(
                            radius: AppSizes.r10,
                            backgroundColor: Colors.white,
                          ),

                          SizedBox(width: AppSizes.w6),

                          Expanded(
                            child: Container(
                              height: AppSizes.h12,
                              color: Colors.white,
                            ),
                          ),

                          SizedBox(width: AppSizes.w10),

                          Container(
                            width: AppSizes.w40,
                            height: AppSizes.h12,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
