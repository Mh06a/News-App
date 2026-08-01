import 'package:news_app/core/datasource/local_data/hive_manager.dart';
import 'package:news_app/core/datasource/local_data/preferences_manager.dart';
import 'package:news_app/core/datasource/local_data/storage_key.dart';
import 'package:news_app/features/user/model/user_model.dart';

class UserRepository {
  UserRepository._internal();
  static final UserRepository _instance = UserRepository._internal();
  factory UserRepository() => _instance;

  final HiveManager _manager = HiveManager();

  //==============================
  // Users
  //==============================

  Future<void> registerUser(UserModel user) async {
    await _manager.userBox.put(user.userId, user);
  }

  Future<void> updateUser(UserModel user) async {
    await _manager.userBox.put(user.userId, user);
  }

  UserModel? getUserById(String userId) {
    return _manager.userBox.get(userId);
  }

  UserModel? getUserByEmail(String email) {
    for (final user in _manager.userBox.values) {
      if (user.email == email) {
        return user;
      }
    }

    return null;
  }

  List<UserModel> getAllUsers() {
    return _manager.userBox.values.toList();
  }

  bool emailExists(String email) {
    return getUserByEmail(email) != null;
  }

  UserModel? login(String email, String password) {
    for (final user in _manager.userBox.values) {
      if (user.email == email && user.password == password) {
        return user;
      }
    }

    return null;
  }

  //==============================
  // Current User
  //==============================

  Future<void> setCurrentUser(String userId) async {
    await PreferencesManager().setString(StorageKey.currentUserId, userId);
  }

  UserModel? getCurrentUser() {
    final userId = PreferencesManager().getString(StorageKey.currentUserId);

    if (userId == null) return null;

    return getUserById(userId);
  }

  Future<void> clearCurrentUser() async {
    await PreferencesManager().remove(StorageKey.currentUserId);
  }

  Future<void> logout() async {
    await clearCurrentUser();

    await PreferencesManager().setBool(StorageKey.isLoggedIn, false);
  }

  Future<bool> checkLogin() async {
    final loggedIn =
        PreferencesManager().getBool(StorageKey.isLoggedIn) ?? false;

    if (!loggedIn) return false;

    return getCurrentUser() != null;
  }
}
