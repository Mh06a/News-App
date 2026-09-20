import 'package:news_app/Domain/entities/article.dart';
import 'package:news_app/Domain/repositories/bookmark_repository.dart';

class AddBookmark {
  //step1 -->> class's variables :
  final BookmarkRepository repository;


  //step2 -->> Constructor :
  const AddBookmark(this.repository);


  //step3 --> create function to use in presentation layer :
  Future<void> call(Article article) {
    return repository.addBookmark(article);
  }
}