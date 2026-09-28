import 'dart:io';
import 'package:news_app/core/constants/storage_constants.dart';
import 'package:news_app/core/error/exceptions.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthException;

abstract class SupabaseStorageDataSource {
  Future<String> uploadAvatar({
    required String filePath,
  });

  Future<void> deleteAvatar({
    required String avatarPath,
  });

  Future<String> getAvatarUrl({
    required String avatarPath,
  });
}


class SupabaseStorageDataSourceImpl implements SupabaseStorageDataSource {
  //step1 -->> class's variables :
  final SupabaseClient supabase;


  //step2 -->> Constructor :
  const SupabaseStorageDataSourceImpl({
    required this.supabase,
  });


  //step3 --> here I will call SupabaseStorageDataSource functions with implements:
  //uploadAvatar
  @override
  Future<String> uploadAvatar({
    required String filePath,
  }) async {
    try {
      final user = supabase.auth.currentUser;

      if (user == null) {
        throw const AuthException(
          'User is not authenticated.',
        );
      }

      final file = File(filePath);

      if (!await file.exists()) {
        throw const ValidationException(
          'Avatar file does not exist.',
        );
      }

      final avatarPath = '${user.id}/profile.jpg';

      await supabase.storage
          .from(StorageConstants.avatarsBucket)
          .upload(
        avatarPath,
        file,
        fileOptions: const FileOptions(
          upsert: true,
        ),
      );

      return avatarPath;
    } on AuthException {
      rethrow;
    } on ValidationException {
      rethrow;
    } on StorageException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw UnknownException(e.toString());
    }
  }


  //deleteAvatar
  @override
  Future<void> deleteAvatar({
    required String avatarPath,
  }) async {
    try {
      await supabase.storage
          .from(StorageConstants.avatarsBucket)
          .remove([
        avatarPath,
      ]);
    } on StorageException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw UnknownException(e.toString());
    }
  }


  //getAvatarUrl
  @override
  Future<String> getAvatarUrl({
    required String avatarPath,
  }) async {
    try {
      return await supabase.storage
          .from(StorageConstants.avatarsBucket)
          .createSignedUrl(
        avatarPath,
        60 * 60,
      );
    } on StorageException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw UnknownException(e.toString());
    }
  }
}