import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/constants/app_sizes.dart';
import 'package:news_app/core/datasource/resmote_data/api_client.dart';
import 'package:news_app/core/themes/app_colors.dart';
import 'package:news_app/features/details/view/news_details_screen.dart';
import 'package:news_app/features/news/controller/news_controller.dart';
import 'package:news_app/features/news/repository/news_repository.dart';
import 'package:news_app/features/search/cubit/search_cubit.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SearchCubit(NewsController(NewsRepository(ApiClient()))),
      child: Scaffold(
        appBar: AppBar(centerTitle: true, title: Text("Search")),
        body: Padding(
          padding: EdgeInsets.all(AppSizes.w16),
          child: BlocBuilder<SearchCubit, SearchState>(
            builder: (context, state) {
              return Column(
                children: [
                  TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hint: Text(
                        "Search",
                        style: TextStyle(
                          color: AppColors.tertiaryText,
                          fontSize: AppSizes.font15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppSizes.r4),
                        borderSide: BorderSide(width: 2),
                      ),
                      suffixIcon: Icon(
                        Icons.search,
                        size: AppSizes.r18,
                        color: AppColors.tertiaryText,
                      ),
                    ),
                    onChanged: (value) {
                      context.read<SearchCubit>().loadGetEverything(
                        query: value,
                      );
                    },
                  ),

                  SizedBox(height: AppSizes.h20),

                  Expanded(
                    child: ListView.separated(
                      itemCount: state.newsEverythingList.length,
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        final news = state.newsEverythingList[index];
                        return Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: AppSizes.w8,
                          ),
                          child: ListTile(
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
                            leading: Icon(
                              Icons.search,
                              size: AppSizes.r18,
                              color: AppColors.tertiaryText,
                            ),
                            title: Text(
                              news.title,
                              style: TextStyle(
                                fontSize: AppSizes.font16,
                                fontWeight: FontWeight.w400,
                                color: AppColors.placeholderText,
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return Divider(
                          color: AppColors.border,
                          radius: BorderRadius.circular(AppSizes.r4),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
