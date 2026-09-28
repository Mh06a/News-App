import 'article_model.dart';

class NewsResponseModel {
  //step1 -->> class's variables :
  final int totalArticles;
  final List<ArticleModel> articles;

  //step2 -->> Constructor :
  const NewsResponseModel({
    required this.totalArticles,
    required this.articles,
  });

  //step3 -->> create factory constructor name fromJson :
  factory NewsResponseModel.fromJson(Map<String, dynamic> json) {
    final articlesJson = json['articles'] as List<dynamic>? ?? [];

    return NewsResponseModel(
      totalArticles: json['totalArticles'] as int? ?? 0,
      articles: articlesJson
          .map(
            (article) => ArticleModel.fromJson(
          article as Map<String, dynamic>,
        ),
      )
          .toList(),
    );
  }
}