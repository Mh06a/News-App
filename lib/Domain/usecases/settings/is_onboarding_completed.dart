import 'package:news_app/Domain/repositories/local_settings_repository.dart';
import 'package:news_app/core/result/result.dart';

class IsOnboardingCompleted {
  //step1 -->> class's variables :
  final LocalSettingsRepository repository;

  //step2 -->> Constructor :
  const IsOnboardingCompleted(this.repository);

  //step3 --> create function to use in presentation layer :
  Future<Result<bool>> call() {
    return repository.isOnboardingCompleted();
  }
}