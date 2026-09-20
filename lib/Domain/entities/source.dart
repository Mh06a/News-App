import 'package:equatable/equatable.dart';

class Source  extends Equatable{
  //step1 -->> class's variables :
  final String? id;
  final String name;
  final String? url;
  final String? country;


  //step2 -->> Constructor :
  const Source({
    this.id,
    required this.name,
    this.url,
    this.country,
  });


  //step3 -->> use Equatable :
  @override
  List<Object?> get props => [id , name , url , country];
}