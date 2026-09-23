import 'package:news_app/Domain/repositories/auth_repository.dart';
import 'package:news_app/core/result/result.dart';


class ResetPassword {
  //step1 -->> class's variables :
  final AuthRepository repository;


  //step2 -->> Constructor :
  const ResetPassword(this.repository);


  //step3 --> create function to use in presentation layer :
  Future<Result<void>> call({required String email}) {
    return repository.resetPassword(email: email);
  }
}