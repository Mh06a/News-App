import 'package:news_app/features/news/model/news.dart';
import 'package:news_app/features/news/repository/news_repository.dart';

class NewsController {
  //step1 -->> class's variables :
  final NewsRepository repository;

  NewsController(this.repository);

  //step3 -->> getTopHeadlines function :
  Future<List<News>> getEverything({required String query}) async {
    return await repository.getEverything(query: query);
  }

  //step4 -->> getEverything function :
  Future<List<News>> getTopHeadlines({
    required String country,
    String? category,
  }) async {
    return await repository.getTopHeadlines(
      country: country,
      category: category,
    );
  }
}
