import 'package:news_app/Data/dataSource/remote/supabase_auth_data_source.dart';
import 'package:news_app/Data/models/user_model.dart';
import 'package:news_app/Domain/repositories/auth_repository.dart';
import 'package:news_app/core/error/exceptions.dart';
import 'package:news_app/core/error/failure.dart';
import 'package:news_app/core/result/result.dart';

class AuthRepositoryImpl implements AuthRepository {
  //step1 --> create class's variable :
  final SupabaseAuthDataSource remoteDataSource;

  //step2 -->> Constructor :
  const AuthRepositoryImpl({
    required this.remoteDataSource,
  });


  //step3 --> here I will call AuthRepository functions with implements :
  //-----signUp-----
  @override
  Future<Result<UserModel>> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final user = await remoteDataSource.signUp(
        name: name,
        email: email,
        password: password,
      );

      return Success(user);
    } on AuthException catch (e) {
      return FailureResult(
        AuthFailure(e.message),
      );
    } on NetworkException catch (e) {
      return FailureResult(
        NetworkFailure(e.message),
      );
    } on ServerException catch (e) {
      return FailureResult(
        ServerFailure(e.message),
      );
    } on UnknownException catch (e) {
      return FailureResult(
        UnknownFailure(e.message),
      );
    }
  }


  //-----signIn-----
  @override
  Future<Result<UserModel>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final user = await remoteDataSource.signIn(
        email: email,
        password: password,
      );

      return Success(user);
    } on AuthException catch (e) {
      return FailureResult(
        AuthFailure(e.message),
      );
    } on NetworkException catch (e) {
      return FailureResult(
        NetworkFailure(e.message),
      );
    } on ServerException catch (e) {
      return FailureResult(
        ServerFailure(e.message),
      );
    } on UnknownException catch (e) {
      return FailureResult(
        UnknownFailure(e.message),
      );
    }
  }


  //-----signInWithGoogle-----
  @override
  Future<Result<UserModel>> signInWithGoogle() async {
    try {
      final user = await remoteDataSource.signInWithGoogle();

      return Success(user);
    } on AuthException catch (e) {
      return FailureResult(
        AuthFailure(e.message),
      );
    } on NetworkException catch (e) {
      return FailureResult(
        NetworkFailure(e.message),
      );
    } on ServerException catch (e) {
      return FailureResult(
        ServerFailure(e.message),
      );
    } on UnknownException catch (e) {
      return FailureResult(
        UnknownFailure(e.message),
      );
    }
  }



  //-----signInWithApple-----
  @override
  Future<Result<UserModel>> signInWithApple() async {
    try {
      final user = await remoteDataSource.signInWithApple();

      return Success(user);
    } on AuthException catch (e) {
      return FailureResult(
        AuthFailure(e.message),
      );
    } on NetworkException catch (e) {
      return FailureResult(
        NetworkFailure(e.message),
      );
    } on ServerException catch (e) {
      return FailureResult(
        ServerFailure(e.message),
      );
    } on UnknownException catch (e) {
      return FailureResult(
        UnknownFailure(e.message),
      );
    }
  }



  //-----getCurrentUser-----
  @override
  Future<Result<UserModel?>> getCurrentUser() async {
    try {
      final user = await remoteDataSource.getCurrentUser();

      return Success(user);
    } on AuthException catch (e) {
      return FailureResult(
        AuthFailure(e.message),
      );
    } on NetworkException catch (e) {
      return FailureResult(
        NetworkFailure(e.message),
      );
    } on ServerException catch (e) {
      return FailureResult(
        ServerFailure(e.message),
      );
    } on UnknownException catch (e) {
      return FailureResult(
        UnknownFailure(e.message),
      );
    }
  }



  //-----signOut-----
  @override
  Future<Result<void>> signOut() async {
    try {
      await remoteDataSource.signOut();

      return const Success(null);
    } on AuthException catch (e) {
      return FailureResult(
        AuthFailure(e.message),
      );
    } on NetworkException catch (e) {
      return FailureResult(
        NetworkFailure(e.message),
      );
    } on ServerException catch (e) {
      return FailureResult(
        ServerFailure(e.message),
      );
    } on UnknownException catch (e) {
      return FailureResult(
        UnknownFailure(e.message),
      );
    }
  }



  //-----resetPassword-----
  @override
  Future<Result<void>> resetPassword({
    required String email,
  }) async {
    try {
      await remoteDataSource.resetPassword(
        email: email,
      );

      return const Success(null);
    } on AuthException catch (e) {
      return FailureResult(
        AuthFailure(e.message),
      );
    } on NetworkException catch (e) {
      return FailureResult(
        NetworkFailure(e.message),
      );
    } on ServerException catch (e) {
      return FailureResult(
        ServerFailure(e.message),
      );
    } on UnknownException catch (e) {
      return FailureResult(
        UnknownFailure(e.message),
      );
    }
  }
}