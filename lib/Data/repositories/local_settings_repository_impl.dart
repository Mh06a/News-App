import 'package:news_app/Data/dataSource/local/local_settings_data_source.dart';
import 'package:news_app/Data/dataSource/local/news_cache_data_source.dart';
import 'package:news_app/Domain/repositories/local_settings_repository.dart';
import 'package:news_app/core/error/exceptions.dart';
import 'package:news_app/core/error/failure.dart';
import 'package:news_app/core/result/result.dart';

class LocalSettingsRepositoryImpl implements LocalSettingsRepository {
  //step1 --> create class's variable :
  final LocalSettingsDataSource localDataSource;
  final NewsCacheDataSource cacheDataSource;


  //step2 -->> Constructor :
  const LocalSettingsRepositoryImpl({
    required this.localDataSource,
    required this.cacheDataSource,
  });


  //step3 --> here I will call UserRepository functions with implements :
  //-----isOnboardingCompleted-----
  @override
  Future<Result<bool>> isOnboardingCompleted() async {
    try {
      final result =
      await localDataSource.isOnboardingCompleted();

      return Success(result);
    } on CacheException catch (e) {
      return FailureResult(
        CacheFailure(e.message),
      );
    } on UnknownException catch (e) {
      return FailureResult(
        UnknownFailure(e.message),
      );
    }
  }


  //-----setOnboardingCompleted-----
  @override
  Future<Result<void>> setOnboardingCompleted() async {
    try {
      await localDataSource.setOnboardingCompleted();

      return const Success(null);
    } on CacheException catch (e) {
      return FailureResult(
        CacheFailure(e.message),
      );
    } on UnknownException catch (e) {
      return FailureResult(
        UnknownFailure(e.message),
      );
    }
  }


  //-----getNewsCountry-----
  @override
  Future<Result<String?>> getNewsCountry() async {
    try {
      final country =
      await localDataSource.getNewsCountry();

      return Success(country);
    } on CacheException catch (e) {
      return FailureResult(
        CacheFailure(e.message),
      );
    } on UnknownException catch (e) {
      return FailureResult(
        UnknownFailure(e.message),
      );
    }
  }


  //-----setNewsCountry-----
  @override
  Future<Result<void>> setNewsCountry({
    required String country,
  }) async {
    try {
      await localDataSource.setNewsCountry(
        country: country,
      );

      await cacheDataSource.clearCache();

      return const Success(null);
    } on CacheException catch (e) {
      return FailureResult(CacheFailure(e.message));
    } on UnknownException catch (e) {
      return FailureResult(UnknownFailure(e.message));
    }
  }


  //-----getNewsLanguage-----
  @override
  Future<Result<String?>> getNewsLanguage() async {
    try {
      final language =
      await localDataSource.getNewsLanguage();

      return Success(language);
    } on CacheException catch (e) {
      return FailureResult(
        CacheFailure(e.message),
      );
    } on UnknownException catch (e) {
      return FailureResult(
        UnknownFailure(e.message),
      );
    }
  }


  //-----setNewsLanguage-----
  @override
  Future<Result<void>> setNewsLanguage({
    required String language,
  }) async {
    try {
      await localDataSource.setNewsLanguage(
        language: language,
      );

      await cacheDataSource.clearCache();

      return const Success(null);
    } on CacheException catch (e) {
      return FailureResult(CacheFailure(e.message));
    } on UnknownException catch (e) {
      return FailureResult(UnknownFailure(e.message));
    }
  }


  //-----getBreakingNewsEnabled-----
  @override
  Future<Result<bool>> getBreakingNewsEnabled() async {
    try {
      final enabled =
      await localDataSource.getBreakingNewsEnabled();

      return Success(enabled);
    } on CacheException catch (e) {
      return FailureResult(
        CacheFailure(e.message),
      );
    } on UnknownException catch (e) {
      return FailureResult(
        UnknownFailure(e.message),
      );
    }
  }


  //-----setBreakingNewsEnabled-----
  @override
  Future<Result<void>> setBreakingNewsEnabled({
    required bool enabled,
  }) async {
    try {
      await localDataSource.setBreakingNewsEnabled(
        enabled: enabled,
      );

      return const Success(null);
    } on CacheException catch (e) {
      return FailureResult(
        CacheFailure(e.message),
      );
    } on UnknownException catch (e) {
      return FailureResult(
        UnknownFailure(e.message),
      );
    }
  }
}