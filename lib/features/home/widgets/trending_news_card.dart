import 'package:flutter/material.dart';
import 'package:news_app/core/constants/app_sizes.dart';
import 'package:news_app/core/themes/app_colors.dart';
import 'package:news_app/core/utils/date_formatter.dart';
import 'package:news_app/shared/custom_cached_network_image.dart';
import 'package:news_app/features/details/view/news_details_screen.dart';
import 'package:news_app/features/news/model/news.dart';
import 'package:news_app/shared/bookmark_button.dart';

class TrendingNewsCard extends StatelessWidget {
  final News news;

  const TrendingNewsCard({super.key, required this.news});

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
        padding: EdgeInsets.all(AppSizes.w8),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppSizes.r15),
          child: SizedBox(
            width: AppSizes.w235,
            height: AppSizes.h140,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CustomCachedNetworkImage(
                  imagePath: news.urlToImage,
                  width: AppSizes.w250,
                  height: AppSizes.h240,
                ),

                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withValues(alpha: 0.5),
                          Colors.black.withValues(alpha: 0.7),
                        ],
                      ),
                    ),
                  ),
                ),

                // Bookmark button placed at top-right of the card
                Positioned(
                  top: AppSizes.h8,
                  right: AppSizes.w8,
                  child: BookmarkButton(news: news, size: 20.0),
                ),

                Positioned(
                  bottom: AppSizes.h12,
                  right: AppSizes.w12,
                  left: AppSizes.w12,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        news.title,
                        style: TextStyle(
                          fontSize: AppSizes.font15,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textOnPrimary,
                        ),
                        maxLines: 2,
                      ),
                      SizedBox(height: AppSizes.h6),
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
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
                                      color: AppColors.textOnPrimary,
                                    ),
                                    maxLines: 1,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Text(
                            DateFormatter.format(news.publishedAt),
                            style: TextStyle(
                              fontSize: AppSizes.font15,
                              fontWeight: FontWeight.w400,
                              color: AppColors.textOnPrimary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
