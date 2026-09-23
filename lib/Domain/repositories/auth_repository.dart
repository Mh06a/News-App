import 'package:news_app/Domain/entities/user.dart';
import 'package:news_app/core/result/result.dart';

abstract class AuthRepository {

  //step1 -->> create function to sign up :
  Future<Result<User>> signUp({
    required String name,
    required String email,
    required String password,
  });


  //step2 -->> create function to sign in :
  Future<Result<User>> signIn({
    required String email,
    required String password,
  });


  //step3 -->> create function to sign in with google :
  Future<Result<User>> signInWithGoogle();


  //step4 -->> create function to sign in with apple :
  Future<Result<User>> signInWithApple();


  //step5 -->> create function to sign out :
  Future<void> signOut();


  //step6 -->> create function to get current user :
  Future<Result<User?>> getCurrentUser();


  //step7 -->> create function to reset password :
  Future<Result<void>> resetPassword({
    required String email,
  });
}