import 'package:news_app/Domain/repositories/user_repository.dart';
import 'package:news_app/core/result/result.dart';

class DeleteAccount {
  //step1 -->> class's variables :
  final UserRepository repository;


  //step2 -->> Constructor :
  const DeleteAccount(this.repository);


  //step3 --> create function to use in presentation layer :
  Future<Result<void>> call() {
    return repository.deleteAccount();
  }
}