import 'package:news_app/Data/models/user_model.dart';
import 'package:news_app/core/error/exceptions.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthException;

abstract class SupabaseUserDataSource {
  Future<UserModel> getProfile();

  Future<UserModel> updateProfile({
    required String name,
    String? location,
  });

  Future<UserModel> updateAvatarPath({
    required String avatarPath,
  });
}


class SupabaseUserDataSourceImpl implements SupabaseUserDataSource {
  //step1 -->> class's variables :
  final SupabaseClient supabase;


  //step2 -->> Constructor :
  const SupabaseUserDataSourceImpl({
    required this.supabase,
  });

  //step3 --> here I will call SupabaseUserDataSource functions with implements:
  //getProfile
  @override
  Future<UserModel> getProfile() async {
    try {
      final user = supabase.auth.currentUser;

      if (user == null) {
        throw const AuthException(
          'User is not authenticated.',
        );
      }

      final response = await supabase
          .from('profiles')
          .select()
          .eq('id', user.id)
          .single();

      final data = Map<String, dynamic>.from(response);

      data['email'] = user.email ?? '';

      return UserModel.fromJson(data);
    } on AuthException {
      rethrow;
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw UnknownException(e.toString());
    }
  }


  //updateProfile
  @override
  Future<UserModel> updateProfile({
    required String name,
    String? location,
  }) async {
    try {
      final user = supabase.auth.currentUser;

      if (user == null) {
        throw const AuthException(
          'User is not authenticated.',
        );
      }

      final response = await supabase
          .from('profiles')
          .update({
        'name': name,
        'location': location,
        'updated_at': DateTime.now().toUtc().toIso8601String(),
      })
          .eq('id', user.id)
          .select()
          .single();

      final data = Map<String, dynamic>.from(response);

      data['email'] = user.email ?? '';

      return UserModel.fromJson(data);
    } on AuthException {
      rethrow;
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw UnknownException(e.toString());
    }
  }


  //updateAvatarPath
  @override
  Future<UserModel> updateAvatarPath({
    required String avatarPath,
  }) async {
    try {
      final user = supabase.auth.currentUser;

      if (user == null) {
        throw const AuthException('User is not authenticated.');
      }

      final response = await supabase
          .from('profiles')
          .update({
        'avatar_path': avatarPath,
        'updated_at': DateTime.now().toUtc().toIso8601String(),
      })
          .eq('id', user.id)
          .select()
          .single();

      final data = Map<String, dynamic>.from(response);
      data['email'] = user.email ?? '';

      return UserModel.fromJson(data);
    } on AuthException {
      rethrow;
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw UnknownException(e.toString());
    }
  }
}