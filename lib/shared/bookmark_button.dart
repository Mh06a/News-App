import 'package:flutter/material.dart';
import 'package:news_app/features/bookmark/repository/bookmark_repository.dart';
import 'package:news_app/features/news/model/news.dart';

class BookmarkButton extends StatefulWidget {
  final News news;
  final double size;
  final VoidCallback? onChanged;

  const BookmarkButton({
    super.key,
    required this.news,
    this.size = 24,
    this.onChanged,
  });

  @override
  State<BookmarkButton> createState() => _BookmarkButtonState();
}

class _BookmarkButtonState extends State<BookmarkButton> {
  final BookmarkRepository _repository = BookmarkRepository();

  bool _isBookmarked = false;

  @override
  void initState() {
    super.initState();
    _isBookmarked = _repository.isBookmarked(widget.news.url);
  }

  Future<void> _toggleBookmark() async {
    final wasAdded = await _repository.toggleBookmark(widget.news);

    if (!mounted) return;

    setState(() {
      _isBookmarked = wasAdded;
    });

    widget.onChanged?.call();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: _toggleBookmark,
      icon: Icon(
        _isBookmarked ? Icons.bookmark : Icons.bookmark_border,
        size: widget.size,
      ),
    );
  }
}
