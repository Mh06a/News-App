import 'package:news_app/Data/models/source_model.dart';
import 'package:news_app/Domain/entities/bookmark.dart';
import 'article_model.dart';

class BookmarkModel extends Bookmark {
  //step1 -->> Constructor :
  const BookmarkModel({
    super.id,
    required super.userId,
    required super.article,
    required super.createdAt ,
  });


  //step2 -->> create factory constructor name fromJson :
  factory BookmarkModel.fromJson(Map<String, dynamic> json) {
    return BookmarkModel(
      id: json['id']?.toString(),
      userId: json['user_id'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      article: ArticleModel(
        id: json['article_id'] as String,
        title: json['title'] as String? ?? '',
        description: json['description'] as String?,
        content: json['content'] as String?,
        image: json['image'] as String?,
        url: json['url'] as String? ?? '',
        publishedAt: json['published_at'] != null
            ? DateTime.tryParse(json['published_at'] as String)
            : null,
        language: json['language'] as String?,
        source: SourceModel(
          id: json['source_id'] as String?,
          name: json['source_name'] as String? ?? '',
          url: json['source_url'] as String?,
          country: json['source_country'] as String?,
        ),
      ),
    );
  }


  //step3 -->> create function to convert to json :
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'article_id': article.id,
      'title': article.title,
      'description': article.description,
      'content': article.content,
      'image': article.image,
      'url': article.url,
      'published_at': article.publishedAt?.toIso8601String(),
      'language': article.language,
      'source_id': article.source.id,
      'source_name': article.source.name,
      'source_url': article.source.url,
      'source_country': article.source.country,
      'created_at': createdAt.toIso8601String(),
    };
  }
}