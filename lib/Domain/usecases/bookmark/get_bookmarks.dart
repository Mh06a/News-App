import 'package:news_app/Domain/entities/bookmark.dart';
import 'package:news_app/Domain/repositories/bookmark_repository.dart';
import 'package:news_app/core/result/result.dart';

class GetBookmarks {
  //step1 -->> class's variables :
  final BookmarkRepository repository;


  //step2 -->> Constructor :
  const GetBookmarks(this.repository);


  //step3 --> create function to use in presentation layer :
  Future<Result<List<Bookmark>>> call() {
    return repository.getBookmarks();
  }
}