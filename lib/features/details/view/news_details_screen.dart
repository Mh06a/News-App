import 'package:flutter/material.dart';
import 'package:news_app/core/constants/app_sizes.dart';
import 'package:news_app/core/themes/app_colors.dart';
import 'package:news_app/core/utils/date_formatter.dart';
import 'package:news_app/shared/custom_cached_network_image.dart';
import 'package:news_app/features/news/model/news.dart';
import 'package:news_app/shared/bookmark_button.dart';

class NewsDetailsScreen extends StatelessWidget {
  //step1 -->> class's variables :
  final News model;

  //step2 -->> Constructor :
  const NewsDetailsScreen({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("News Details"), centerTitle: true),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppSizes.w16),
          child: Column(
            children: [
              SizedBox(height: AppSizes.h8),
              ClipRRect(
                borderRadius: BorderRadius.circular(AppSizes.r4),
                child: CustomCachedNetworkImage(
                  imagePath: model.urlToImage,
                  height: AppSizes.h240,
                  width: double.infinity,
                ),
              ),

              SizedBox(height: AppSizes.h12),

              Text(
                model.title,
                style: TextStyle(
                  fontSize: AppSizes.font20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textThirdColor,
                ),
              ),

              SizedBox(height: AppSizes.h10),

              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(model.urlToImage),
                    radius: AppSizes.r15,
                  ),

                  SizedBox(width: AppSizes.w6),

                  Expanded(
                    child: Row(
                      children: [
                        Text(
                          model.author,
                          style: TextStyle(
                            fontSize: AppSizes.font15,
                            fontWeight: FontWeight.w400,
                            color: AppColors.textThirdColor,
                          ),
                        ),
                        SizedBox(width: AppSizes.w12),

                        Expanded(
                          child: Text(
                            DateFormatter.format(model.publishedAt),
                            style: TextStyle(
                              fontSize: AppSizes.font13,
                              fontWeight: FontWeight.w400,
                              color: AppColors.secondary,
                            ),
                          ),
                        ),

                        BookmarkButton(news: model),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: AppSizes.h16),

              Text(
                model.description,
                style: TextStyle(
                  fontSize: AppSizes.font16,
                  fontWeight: FontWeight.w400,
                  color: AppColors.secondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
