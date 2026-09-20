

import 'package:news_app/Domain/repositories/auth_repository.dart';

class SignOut {
  //step1 -->> class's variables :
  final AuthRepository repository;


  //step2 -->> Constructor :
  const SignOut(this.repository);


  //step3 --> create function to use in presentation layer :
  Future<void> call() {
    return repository.signOut();
  }
}