import 'package:hive_flutter/hive_flutter.dart';
import 'package:news_app/features/news/model/news.dart';

@HiveType(typeId: 1)
class BookmarkModel {
  @HiveField(0)
  final String url;
  @HiveField(1)
  final String author;
  @HiveField(2)
  final String title;
  @HiveField(3)
  final String description;
  @HiveField(4)
  final String urlToImage;
  @HiveField(5)
  final String publishedAt;
  @HiveField(6)
  final String userId;

  BookmarkModel({
    required this.url,
    required this.author,
    required this.title,
    required this.description,
    required this.urlToImage,
    required this.publishedAt,
    required this.userId,
  });

  factory BookmarkModel.fromMap(Map<String, dynamic> map) {
    return BookmarkModel(
      url: map['url'] ?? '',
      author: map['author'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      urlToImage: map['urlToImage'] ?? '',
      publishedAt: map['publishedAt'] ?? '',
      userId: map['userId'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'url': url,
      'author': author,
      'title': title,
      'description': description,
      'urlToImage': urlToImage,
      'publishedAt': publishedAt,
      'userId': userId,
    };
  }

  BookmarkModel copyWith({
    String? url,
    String? author,
    String? title,
    String? description,
    String? urlToImage,
    String? publishedAt,
    String? userId,
  }) {
    return BookmarkModel(
      url: url ?? this.url,
      author: author ?? this.author,
      title: title ?? this.title,
      description: description ?? this.description,
      urlToImage: urlToImage ?? this.urlToImage,
      publishedAt: publishedAt ?? this.publishedAt,
      userId: userId ?? this.userId,
    );
  }

  News toNews() {
    return News(
      author: author,
      title: title,
      description: description,
      url: url,
      urlToImage: urlToImage,
      publishedAt: publishedAt,
      content: description,
    );
  }
}
