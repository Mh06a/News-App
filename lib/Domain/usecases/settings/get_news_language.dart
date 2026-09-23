import 'package:news_app/Domain/repositories/local_settings_repository.dart';
import 'package:news_app/core/result/result.dart';

class GetNewsLanguage {
  //step1 -->> class's variables :
  final LocalSettingsRepository repository;

  //step2 -->> Constructor :
  const GetNewsLanguage(this.repository);

  //step3 --> create function to use in presentation layer :
  Future<Result<String?>> call() {
    return repository.getNewsLanguage();
  }
}