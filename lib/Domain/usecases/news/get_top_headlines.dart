import 'package:news_app/Domain/entities/article.dart';
import 'package:news_app/Domain/repositories/news_repository.dart';
import 'package:news_app/core/result/result.dart';

class GetTopHeadlines {
  //step1 -->> class's variables :
  final NewsRepository repository;


  //step2 -->> Constructor :
  const GetTopHeadlines(this.repository);


  //step3 --> create function to use in presentation layer :
  Future<Result<List<Article>>> call({
    String? category,
    String? language,
    String? country,
    int page = 1,
  }) {
    return repository.getTopHeadlines(
      category: category,
      language: language,
      country: country,
      page: page,
    );
  }
}