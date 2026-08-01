import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/enums/request_status_enum.dart';
import 'package:news_app/features/bookmark/cubit/bookmark_cubit.dart';
import 'package:news_app/features/bookmark/repository/bookmark_repository.dart';
import 'package:news_app/features/bookmark/widgets/bookmark_card.dart';

class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BookmarkCubit(BookmarkRepository()),
      child: Scaffold(
        appBar: AppBar(centerTitle: true, title: Text("Bookmarks")),
        body: BlocBuilder<BookmarkCubit, BookmarkState>(
          builder: (context, state) {
            switch (state.bookmarkStatus) {
              case RequestStatusEnum.loading:
                return const Center(child: CircularProgressIndicator());

              case RequestStatusEnum.error:
                return Center(
                  child: Text(state.errorMessage ?? 'Something went wrong'),
                );

              case RequestStatusEnum.loaded:
                if (state.bookmarks.isEmpty) {
                  return const Center(child: Text('No bookmarks yet'));
                }

                return ListView.builder(
                  itemCount: state.bookmarks.length,
                  itemBuilder: (context, index) {
                    return BookmarkCard(
                      bookmark: state.bookmarks[index],
                      onChanged: () {
                        context.read<BookmarkCubit>().loadBookmarks();
                      },
                    );
                  },
                );
            }
          },
        ),
      ),
    );
  }
}
