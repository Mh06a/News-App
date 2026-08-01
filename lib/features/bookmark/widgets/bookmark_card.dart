import 'package:flutter/material.dart';
import 'package:news_app/core/constants/app_sizes.dart';
import 'package:news_app/core/themes/app_colors.dart';
import 'package:news_app/core/utils/date_formatter.dart';
import 'package:news_app/features/bookmark/model/bookmark_model.dart';
import 'package:news_app/features/details/view/news_details_screen.dart';
import 'package:news_app/shared/custom_cached_network_image.dart';
import 'package:news_app/shared/bookmark_button.dart';

class BookmarkCard extends StatelessWidget {
  final BookmarkModel bookmark;
  final VoidCallback? onChanged;

  const BookmarkCard({super.key, required this.bookmark, this.onChanged});

  @override
  Widget build(BuildContext context) {
    // Convert BookmarkModel -> News to reuse the shared BookmarkButton API

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return NewsDetailsScreen(model: bookmark.toNews());
            },
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.all(AppSizes.w16),
        child: Column(
          children: [
            SizedBox(height: AppSizes.h8),
            ClipRRect(
              borderRadius: BorderRadius.circular(AppSizes.r4),
              child: CustomCachedNetworkImage(
                imagePath: bookmark.urlToImage,
                height: AppSizes.h240,
                width: double.infinity,
              ),
            ),

            SizedBox(height: AppSizes.h12),

            Text(
              bookmark.title,
              style: TextStyle(
                fontSize: AppSizes.font16,
                fontWeight: FontWeight.w700,
                color: AppColors.textThirdColor,
              ),
              maxLines: 2,
            ),

            SizedBox(height: AppSizes.h10),

            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(bookmark.urlToImage),
                  radius: AppSizes.r15,
                ),

                SizedBox(width: AppSizes.w6),

                Expanded(
                  child: Row(
                    children: [
                      Text(
                        bookmark.author,
                        style: TextStyle(
                          fontSize: AppSizes.font15,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textThirdColor,
                        ),
                      ),
                      SizedBox(width: AppSizes.w12),

                      Expanded(
                        child: Text(
                          DateFormatter.format(bookmark.publishedAt),
                          style: TextStyle(
                            fontSize: AppSizes.font13,
                            fontWeight: FontWeight.w400,
                            color: AppColors.secondary,
                          ),
                        ),
                      ),

                      // Use the shared BookmarkButton with news conversion
                      BookmarkButton(
                        news: bookmark.toNews(),
                        onChanged: onChanged,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
