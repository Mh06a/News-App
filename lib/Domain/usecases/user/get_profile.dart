import 'package:news_app/Domain/entities/user.dart';
import 'package:news_app/Domain/repositories/user_repository.dart';
import 'package:news_app/core/result/result.dart';

class GetProfile {
  //step1 -->> class's variables :
  final UserRepository repository;


  //step2 -->> Constructor :
  const GetProfile(this.repository);


  //step3 --> create function to use in presentation layer :
  Future<Result<User>> call() {
    return repository.getProfile();
  }
}