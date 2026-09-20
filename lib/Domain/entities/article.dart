import 'package:equatable/equatable.dart';
import 'source.dart';

class Article extends Equatable {
  //step1 -->> class's variables :
  final String id;
  final String title;
  final String? description;
  final String? content;
  final String? image;
  final String url;
  final DateTime? publishedAt;
  final String? language;
  final Source source;


  //step2 -->> Constructor :
  const Article({
    required this.id,
    required this.title,
    this.description,
    this.content,
    this.image,
    required this.url,
    this.publishedAt,
    this.language,
    required this.source,
  });


  //step3 -->> use Equatable :
  @override
  List<Object?> get props => [id , title , description , content , image ,
  url , publishedAt , language , source
  ];
}