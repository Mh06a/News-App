import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:news_app/Data/models/user_model.dart';
import 'package:news_app/core/error/exceptions.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

abstract class SupabaseAuthDataSource {
  Future<UserModel> signUp({
    required String name,
    required String email,
    required String password,
  });

  Future<UserModel> signIn({
    required String email,
    required String password,
  });

  Future<UserModel> signInWithGoogle();

  Future<UserModel> signInWithApple();

  Future<UserModel?> getCurrentUser();

  Future<void> signOut();

  Future<void> resetPassword({
    required String email,
  });
}


class SupabaseAuthDataSourceImpl implements SupabaseAuthDataSource {
  // Step 1 -- Class variables
  final supabase.SupabaseClient supabaseClient;

  // Step 2 -- Constructor
  const SupabaseAuthDataSourceImpl({
    required this.supabaseClient,
  });

  // Step 3 -- Implement SupabaseAuthDataSource functions
  // Sign Up
  @override
  Future<UserModel> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signUp(
        email: email,
        password: password,
        data: {
          'full_name': name,
        },
      );

      final user = response.user;

      if (user == null) {
        throw const AuthException(
          'Account could not be created.',
        );
      }

      return UserModel(
        id: user.id,
        name: name,
        email: user.email ?? email,
      );
    } on AuthException {
      rethrow;
    } on supabase.AuthException catch (e) {
      throw AuthException(e.message);
    } catch (e) {
      throw UnknownException(e.toString());
    }
  }

  // Sign In
  @override
  Future<UserModel> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      );

      final user = response.user;

      if (user == null) {
        throw const AuthException(
          'Invalid email or password.',
        );
      }

      return UserModel(
        id: user.id,
        name: user.userMetadata?['full_name'] as String? ??
            user.userMetadata?['name'] as String? ??
            '',
        email: user.email ?? email,
      );
    } on AuthException {
      rethrow;
    } on supabase.AuthException catch (e) {
      throw AuthException(e.message);
    } catch (e) {
      throw UnknownException(e.toString());
    }
  }

  // Sign In With Google
  @override
  Future<UserModel> signInWithGoogle() async {
    try {
      final googleAccount =
      await GoogleSignIn.instance.authenticate();
      final authentication = googleAccount.authentication;
      final idToken = authentication.idToken;

      if (idToken == null) {
        throw const AuthException(
          'Google sign in failed: no ID token.',
        );
      }

      final authorization =
      await googleAccount.authorizationClient.authorizationForScopes(const <String>[],);

      final accessToken = authorization?.accessToken;

      if (accessToken == null) {
        throw const AuthException(
          'Google sign in failed: no access token.',
        );
      }

      final response = await supabaseClient.auth.signInWithIdToken(
        provider: supabase.OAuthProvider.google,
        idToken: idToken,
        accessToken: accessToken,
      );

      final user = response.user;

      if (user == null) {
        throw const AuthException(
          'Google sign in failed.',
        );
      }

      return UserModel(
        id: user.id,
        name: user.userMetadata?['full_name'] as String? ??
            user.userMetadata?['name'] as String? ?? '',
        email: user.email ?? '',
      );
    } on AuthException {
      rethrow;
    } on GoogleSignInException catch (e) {
      throw AuthException(
        'Google sign in failed: ${e.description}',
      );
    } on supabase.AuthException catch (e) {
      throw AuthException(e.message);
    } catch (e) {
      throw UnknownException(e.toString());
    }
  }


  // Sign In With Apple
  @override
  Future<UserModel> signInWithApple() async {
    try {
      final rawNonce = supabaseClient.auth.generateRawNonce();

      final hashedNonce = sha256
          .convert(utf8.encode(rawNonce))
          .toString();

      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: hashedNonce,
      );

      final idToken = credential.identityToken;

      if (idToken == null) {
        throw const AuthException(
          'Apple sign in failed: no ID token.',
        );
      }

      final response = await supabaseClient.auth.signInWithIdToken(
        provider: supabase.OAuthProvider.apple,
        idToken: idToken,
        nonce: rawNonce,
      );

      final user = response.user;

      if (user == null) {
        throw const AuthException(
          'Apple sign in failed.',
        );
      }

      final appleName = [
        credential.givenName,
        credential.familyName,
      ].where(
            (name) => name != null && name.isNotEmpty,
      ).join(' ');

      final metadataName =
          user.userMetadata?['full_name'] as String? ??
              user.userMetadata?['name'] as String? ??
              '';

      return UserModel(
        id: user.id,
        name: appleName.isNotEmpty
            ? appleName
            : metadataName,
        email: user.email ?? '',
      );
    } on AuthException {
      rethrow;
    } on SignInWithAppleAuthorizationException catch (e) {
      throw AuthException(
        'Apple sign in failed: ${e.message}',
      );
    } on supabase.AuthException catch (e) {
      throw AuthException(e.message);
    } catch (e) {
      throw UnknownException(e.toString());
    }
  }

  // Get Current User
  @override
  Future<UserModel?> getCurrentUser() async {
    try {
      final user = supabaseClient.auth.currentUser;

      if (user == null) {
        return null;
      }

      return UserModel(
        id: user.id,
        name: user.userMetadata?['full_name'] as String? ??
            user.userMetadata?['name'] as String? ??
            '',
        email: user.email ?? '',
      );
    } catch (e) {
      throw UnknownException(e.toString());
    }
  }

  // Sign Out
  @override
  Future<void> signOut() async {
    try {
      await supabaseClient.auth.signOut();
    } on supabase.AuthException catch (e) {
      throw AuthException(e.message);
    } catch (e) {
      throw UnknownException(e.toString());
    }
  }

  // Reset Password
  @override
  Future<void> resetPassword({
    required String email,
  }) async {
    try {
      await supabaseClient.auth.resetPasswordForEmail(
        email,
      );
    } on supabase.AuthException catch (e) {
      throw AuthException(e.message);
    } catch (e) {
      throw UnknownException(e.toString());
    }
  }
}