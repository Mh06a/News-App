import 'package:news_app/Domain/repositories/bookmark_repository.dart';
import 'package:news_app/core/result/result.dart';

class RemoveBookmark {
  //step1 -->> class's variables :
  final BookmarkRepository repository;


  //step2 -->> Constructor :
  const RemoveBookmark(this.repository);


  //step3 --> create function to use in presentation layer :
  Future<Result<void>> call(String articleId) {
    return repository.removeBookmark(articleId);
  }
}