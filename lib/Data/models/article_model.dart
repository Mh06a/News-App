import 'package:news_app/Data/models/source_model.dart';
import 'package:news_app/Domain/entities/article.dart';

class ArticleModel extends Article {
  //step1 -->> Constructor :
  const ArticleModel({
    required super.id,
    required super.title,
    required super.url,
    required super.source ,
    super.description ,
    super.content ,
    super.image ,
    super.language ,
    super.publishedAt
  });


  //step2 -->> create factory constructor name fromJson :
  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      description: json['description'] as String?,
      content: json['content'] as String?,
      image: json['image'] as String?,
      url: json['url'] as String,
      publishedAt: json['publishedAt'] != null
          ? DateTime.tryParse(json['publishedAt'] as String)
          : null,
      language: json['lang'] as String?,
      source: SourceModel.fromJson(
        json['source'] as Map<String, dynamic>? ?? {},
      ),
    );
  }


  //step3 -->> create function to convert to json :
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'content': content,
      'image': image,
      'url': url,
      'publishedAt': publishedAt?.toIso8601String(),
      'lang': language,
      'source': {
        'id': source.id,
        'name': source.name,
        'url': source.url,
        'country': source.country,
      },
    };
  }

}