import 'package:news_app/core/result/result.dart';

abstract class LocalSettingsRepository {
  //step1 -->> create function to check is onboarding completed :
  Future<Result<bool>> isOnboardingCompleted();


  //step2 -->> create function to set onboarding completed :
  Future<Result<void>> setOnboardingCompleted();


  //step3 -->> create function to get news country :
  Future<Result<String?>> getNewsCountry();


  //step4 -->> create function to set news country :
  Future<Result<void>> setNewsCountry({
    required String country,
  });


  //step5 -->> create function to get news language :
  Future<Result<String?>> getNewsLanguage();


  //step6 -->> create function to set news language :
  Future<Result<void>> setNewsLanguage({
    required String language,
  });


  //step7 -->> create function to get breaking news enabled :
  Future<Result<bool>> getBreakingNewsEnabled();



  //step8 -->> create function to set breaking news enabled :
  Future<Result<void>> setBreakingNewsEnabled({
    required bool enabled,
  });
}