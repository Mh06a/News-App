import 'package:flutter/material.dart';
import 'package:news_app/core/constants/app_sizes.dart';
import 'package:news_app/core/themes/app_colors.dart';
import 'package:news_app/core/utils/date_formatter.dart';
import 'package:news_app/shared/custom_cached_network_image.dart';
import 'package:news_app/features/details/view/news_details_screen.dart';
import 'package:news_app/features/news/model/news.dart';
import 'package:news_app/shared/bookmark_button.dart';

class TopHeadlinesCard extends StatelessWidget {
  final News news;

  const TopHeadlinesCard({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return NewsDetailsScreen(model: news);
            },
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.w16,
          vertical: AppSizes.h8,
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(AppSizes.r12),
              child: CustomCachedNetworkImage(
                imagePath: news.urlToImage,
                width: AppSizes.w130,
                height: AppSizes.h75,
              ),
            ),

            SizedBox(width: AppSizes.w10),

            Expanded(
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Text(
                    news.title,
                    style: TextStyle(
                      fontSize: AppSizes.font16,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textThirdColor,
                    ),
                    maxLines: 2,
                  ),

                  SizedBox(height: AppSizes.h10),

                  Row(
                    children: [
                      CircleAvatar(
                        radius: AppSizes.r10,
                        backgroundColor: Colors.grey.shade300,
                        backgroundImage: news.urlToImage.isNotEmpty
                            ? NetworkImage(news.urlToImage)
                            : null,
                        child: news.urlToImage.isEmpty
                            ? Icon(Icons.person, size: AppSizes.r12)
                            : null,
                      ),

                      SizedBox(width: AppSizes.w6),

                      Expanded(
                        child: Text(
                          news.author,
                          style: TextStyle(
                            fontSize: AppSizes.font13,
                            fontWeight: FontWeight.w400,
                            color: AppColors.textThirdColor,
                          ),
                          maxLines: 1,
                        ),
                      ),

                      SizedBox(width: AppSizes.w8),

                      Text(
                        DateFormatter.format(news.publishedAt),
                        style: TextStyle(
                          fontSize: AppSizes.font15,
                          fontWeight: FontWeight.w400,
                          color: AppColors.secondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            BookmarkButton(news: news, size: 20.0),
          ],
        ),
      ),
    );
  }
}
