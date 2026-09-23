import 'package:equatable/equatable.dart';

class User extends Equatable  {
  //step1 -->> class's variables :
  final String id;
  final String name;
  final String email;
  final String? location;
  final String? avatarPath;


  //step2 -->> Constructor :
  const User({
    required this.id,
    required this.name,
    required this.email,
    this.location,
    this.avatarPath,
  });


  //step3 -->> use Equatable :
  @override
  List<Object?> get props => [
    id,
    name,
    email,
    location,
    avatarPath,
  ];
}