import 'package:news_app/Domain/entities/user.dart';
import 'package:news_app/Domain/repositories/auth_repository.dart';
import 'package:news_app/core/result/result.dart';

class SignIn {
  //step1 -->> class's variables :
  final AuthRepository repository;


  //step2 -->> Constructor :
  const SignIn(this.repository);


  //step3 --> create function to use in presentation layer :
  Future<Result<User>> call({required String email, required String password}) {
    return repository.signIn(email: email, password: password);
  }
}