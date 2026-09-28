import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  final SharedPreferences preferences;

  const LocalStorage(this.preferences);

  Future<bool> setBool(
      String key,
      bool value,
      ) async {
    return preferences.setBool(key, value);
  }

  bool? getBool(String key) {
    return preferences.getBool(key);
  }

  Future<bool> setString(
      String key,
      String value,
      ) async {
    return preferences.setString(key, value);
  }

  String? getString(String key) {
    return preferences.getString(key);
  }

  Future<bool> setStringList(
      String key,
      List<String> value,
      ) async {
    return preferences.setStringList(key, value);
  }

  List<String>? getStringList(String key) {
    return preferences.getStringList(key);
  }

  Future<bool> remove(String key) async {
    return preferences.remove(key);
  }

  Future<bool> clear() async {
    return preferences.clear();
  }
}