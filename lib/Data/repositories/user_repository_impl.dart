import 'package:news_app/Data/dataSource/remote/supabase_storage_data_source.dart';
import 'package:news_app/Data/dataSource/remote/supabase_user_data_source.dart';
import 'package:news_app/Domain/entities/user.dart';
import 'package:news_app/Domain/repositories/user_repository.dart';
import 'package:news_app/core/error/exceptions.dart';
import 'package:news_app/core/error/failure.dart';
import 'package:news_app/core/result/result.dart';

class UserRepositoryImpl implements UserRepository {
  //step1 --> create class's variable :
  final SupabaseUserDataSource userDataSource;
  final SupabaseStorageDataSource storageDataSource;


  //step2 -->> Constructor :
  const UserRepositoryImpl({
    required this.userDataSource,
    required this.storageDataSource,
  });


  //step3 --> here I will call NewsRepository functions with implements :
  //-----getProfile-----
  @override
  Future<Result<User>> getProfile() async {
    try {
      final user = await userDataSource.getProfile();
      return Success(user);
    } on AuthException catch (e) {
      return FailureResult(AuthFailure(e.message));
    } on ServerException catch (e) {
      return FailureResult(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return FailureResult(NetworkFailure(e.message));
    } on UnknownException catch (e) {
      return FailureResult(UnknownFailure(e.message));
    }
  }


  //-----updateProfile-----
  @override
  Future<Result<User>> updateProfile({
    required String name,
    String? location,
  }) async {
    try {
      final user = await userDataSource.updateProfile(
        name: name,
        location: location,
      );
      return Success(user);
    } on AuthException catch (e) {
      return FailureResult(AuthFailure(e.message));
    } on ServerException catch (e) {
      return FailureResult(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return FailureResult(NetworkFailure(e.message));
    } on UnknownException catch (e) {
      return FailureResult(UnknownFailure(e.message));
    }
  }


  //-----updateAvatar-----
  @override
  Future<Result<User>> updateAvatar({
    required String filePath,
  }) async {
    try {
      final avatarPath = await storageDataSource.uploadAvatar(
        filePath: filePath,
      );

      final user = await userDataSource.updateAvatarPath(
        avatarPath: avatarPath,
      );

      return Success(user);
    } on AuthException catch (e) {
      return FailureResult(AuthFailure(e.message));
    } on ServerException catch (e) {
      return FailureResult(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return FailureResult(NetworkFailure(e.message));
    } on UnknownException catch (e) {
      return FailureResult(UnknownFailure(e.message));
    }
  }


  //-----getAvatarUrl-----
  @override
  Future<Result<String>> getAvatarUrl({
    required String avatarPath,
  }) async {
    try {
      final url = await storageDataSource.getAvatarUrl(
        avatarPath: avatarPath,
      );
      return Success(url);
    } on AuthException catch (e) {
      return FailureResult(AuthFailure(e.message));
    } on ServerException catch (e) {
      return FailureResult(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return FailureResult(NetworkFailure(e.message));
    } on UnknownException catch (e) {
      return FailureResult(UnknownFailure(e.message));
    }
  }


  //-----deleteAccount-----
  @override
  Future<Result<void>> deleteAccount() async {
    return const FailureResult(
      ServerFailure('Account deletion is not implemented yet.'),
    );
  }
}