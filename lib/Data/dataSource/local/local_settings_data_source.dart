import 'package:news_app/core/constants/storage_constants.dart';
import 'package:news_app/core/storage/local_storage.dart';

abstract class LocalSettingsDataSource {
  Future<bool> isOnboardingCompleted();

  Future<void> setOnboardingCompleted();

  Future<String?> getNewsCountry();

  Future<void> setNewsCountry({
    required String country,
  });

  Future<String?> getNewsLanguage();

  Future<void> setNewsLanguage({
    required String language,
  });

  Future<bool> getBreakingNewsEnabled();

  Future<void> setBreakingNewsEnabled({
    required bool enabled,
  });
}



class LocalSettingsDataSourceImpl implements LocalSettingsDataSource {
  //step1 --> create class's variable :
  final LocalStorage localStorage;


  //step2 --> create constructor :
  const LocalSettingsDataSourceImpl({
    required this.localStorage,
  });


  //step3 --> here I will call LocalSettingsDataSource functions with implements :
  //isOnboardingCompleted
  @override
  Future<bool> isOnboardingCompleted() async {
    return localStorage.getBool(
      StorageConstants.onboardingCompleted,
    ) ??
        false;
  }


  //setOnboardingCompleted
  @override
  Future<void> setOnboardingCompleted() async {
    await localStorage.setBool(
      StorageConstants.onboardingCompleted,
      true,
    );
  }


  //getNewsCountry
  @override
  Future<String?> getNewsCountry() async {
    return localStorage.getString(
      StorageConstants.newsCountry,
    );
  }


  //setNewsCountry
  @override
  Future<void> setNewsCountry({
    required String country,
  }) async {
    await localStorage.setString(
      StorageConstants.newsCountry,
      country,
    );
  }


  //getNewsLanguage
  @override
  Future<String?> getNewsLanguage() async {
    return localStorage.getString(
      StorageConstants.newsLanguage,
    );
  }


  //setNewsLanguage
  @override
  Future<void> setNewsLanguage({
    required String language,
  }) async {
    await localStorage.setString(
      StorageConstants.newsLanguage,
      language,
    );
  }


  //getBreakingNewsEnabled
  @override
  Future<bool> getBreakingNewsEnabled() async {
    return localStorage.getBool(
      StorageConstants.breakingNewsEnabled,
    ) ??
        true;
  }


  //setBreakingNewsEnabled
  @override
  Future<void> setBreakingNewsEnabled({
    required bool enabled,
  }) async {
    await localStorage.setBool(
      StorageConstants.breakingNewsEnabled,
      enabled,
    );
  }
}