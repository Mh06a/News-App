import 'package:news_app/Domain/entities/user.dart';
import 'package:news_app/Domain/repositories/user_repository.dart';
import 'package:news_app/core/result/result.dart';

class UpdateProfile {
  //step1 -->> class's variables :
  final UserRepository repository;


  //step2 -->> Constructor :
  const UpdateProfile(this.repository);


  //step3 --> create function to use in presentation layer :
  Future<Result<User>> call({
    required String name,
    String? country,
    String? language,
  }) {
    return repository.updateProfile(
      name: name,
      country: country,
      language: language,
    );
  }
}