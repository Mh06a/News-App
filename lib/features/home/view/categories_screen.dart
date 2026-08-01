import 'package:flutter/material.dart';
import 'package:news_app/shared/filter_section.dart';
import 'package:news_app/features/home/widgets/top_headlines_section.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("Categories")),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: Filtersection()),

          TopHeadlinesSection(),
        ],
      ),
    );
  }
}
