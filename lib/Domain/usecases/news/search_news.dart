import 'package:news_app/Domain/entities/article.dart';
import 'package:news_app/Domain/repositories/news_repository.dart';
import 'package:news_app/core/result/result.dart';

class SearchNews {
  //step1 -->> class's variables :
  final NewsRepository repository;


  //step2 -->> Constructor :
  const SearchNews(this.repository);


  //step3 --> create function to use in presentation layer :
  Future<Result<List<Article>>> call({
    required String query,
    required String country,
    required String language,
    int page = 1,
  }) {
    return repository.searchNews(
      query: query,
      language: language,
      country: country,
      page: page,
    );
  }
}