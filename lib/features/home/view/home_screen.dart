import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/home/cubit/home_cubit.dart';
import 'package:news_app/shared/filter_section.dart';
import 'package:news_app/features/home/widgets/top_headlines_section.dart';
import 'package:news_app/features/home/widgets/trending_news_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(),
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            TrendingNews(),
            SliverToBoxAdapter(child: Filtersection()),
            TopHeadlinesSection(),
          ],
        ),
      ),
    );
  }
}
