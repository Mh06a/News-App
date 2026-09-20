import 'package:equatable/equatable.dart';
import 'article.dart';

class Bookmark  extends Equatable {
  //step1 -->> class's variables :
  final String id;
  final String userId;
  final Article article;
  final DateTime createdAt;


  //step2 -->> Constructor :
  const Bookmark({
    required this.id,
    required this.userId,
    required this.article,
    required this.createdAt,
  });


  //step3 -->> use Equatable :
  @override
  List<Object?> get props => [id , userId , article , createdAt];
}