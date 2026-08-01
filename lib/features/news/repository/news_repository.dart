import 'package:news_app/core/constants/api_constants.dart';
import 'package:news_app/core/datasource/resmote_data/api_client.dart';
import 'package:news_app/features/news/model/news.dart';

class NewsRepository {
  //step1 -->> class's variables :
  final ApiClient apiService;

  //step2 -->> Constructor :
  NewsRepository(this.apiService);

  //step3 -->>  getEverything function :
  Future<List<News>> getEverything({required String query}) async {
    final data = await apiService.get(
      ApiConstants.everything,
      queryParameters: {"q": query},
    );

    return _parseNews(data);
  }

  //step4 -->> getTopHeadlines function :
  Future<List<News>> getTopHeadlines({
    required String country,
    String? category,
  }) async {
    final data = await apiService.get(
      ApiConstants.topHeadlines,
      queryParameters: {"country": country, "category": category},
    );

    return _parseNews(data);
  }

  //step6 -->> pass function :
  List<News> _parseNews(Map<String, dynamic> data) {
    final List<dynamic> articles = data["articles"] as List<dynamic>? ?? [];

    return articles.map((e) => News.fromJson(e)).toList();
  }
}
