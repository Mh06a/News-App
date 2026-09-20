import 'package:equatable/equatable.dart';

class User extends Equatable  {
  //step1 -->> class's variables :
  final String id;
  final String name;
  final String email;
  final String? country;
  final String? language;


  //step2 -->> Constructor :
  const User({
    required this.id,
    required this.name,
    required this.email,
    this.country,
    this.language,
  });


  //step3 -->> use Equatable :
  @override
  List<Object?> get props => [id , name , email , country , language];
}