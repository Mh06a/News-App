import 'package:news_app/Domain/entities/user.dart';

class UserModel extends User {
  //step1 -->> Constructor :
  const UserModel({
    required super.id,
    required super.name,
    required super.email,
    super.location ,
    super.avatarPath
  });

  //step2 -->> create factory constructor name fromJson :
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      name: json['name'] as String? ?? '',
      email: json['email'] as String? ?? '',
      location: json['location'] as String?,
      avatarPath: json['avatar_path'] as String?,
    );
  }

  //step3 -->> create function to convert to json :
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'location': location,
      'avatar_path': avatarPath,
    };
  }
  
}