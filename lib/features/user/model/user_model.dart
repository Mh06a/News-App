import 'package:hive_flutter/hive_flutter.dart';

@HiveType(typeId: 0)
class UserModel {
  //step1 -->> class's variables :
  @HiveField(0)
  final String userId;

  @HiveField(1)
  final String userName;

  @HiveField(2)
  final String email;

  @HiveField(3)
  final String password;

  @HiveField(4)
  final String? countryName;

  @HiveField(5)
  final String countryCode;

  @HiveField(6)
  final String? imagePath;

  //step2 -->> Constructor :
  const UserModel({
    required this.userId,
    required this.userName,
    required this.email,
    required this.password,
    required this.countryName,
    required this.countryCode,
    this.imagePath,
  });

  UserModel copyWith({
    String? userId,
    String? userName,
    String? email,
    String? password,
    String? countryName,
    String? countryCode,
    String? imagePath,
  }) {
    return UserModel(
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      email: email ?? this.email,
      password: password ?? this.password,
      countryName: countryName ?? this.countryName,
      countryCode: countryCode ?? this.countryCode,
      imagePath: imagePath ?? this.imagePath,
    );
  }
}
