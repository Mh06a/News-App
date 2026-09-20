import 'package:news_app/Domain/entities/user.dart';
import 'package:news_app/core/result/result.dart';

abstract class UserRepository {
  //step1 -->> create function to get profile:
  Future<Result<User>> getProfile();


  //step2 -->> create function to update profile :
  Future<Result<User>> updateProfile({
    required String name,
    String? country,
    String? language,
  });
}