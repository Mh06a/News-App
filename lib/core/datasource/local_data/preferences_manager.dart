import 'package:shared_preferences/shared_preferences.dart';

class PreferencesManager {
  //step1 ----> here Create Var for class :
  static final PreferencesManager _instance = PreferencesManager._internal();
  late final SharedPreferences _preferences;

  //step2 ----> here Create private constructor :
  PreferencesManager._internal();

  //step3 ----> here Create factory constructor :
  factory PreferencesManager() {
    return _instance;
  }

  //step4 ----> here Create init function :
  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  //step5 ----> here Create functions to set :
  Future<bool> setBool(String key, bool value) async {
    return await _preferences.setBool(key, value);
  }

  Future<bool> setString(String key, String value) async {
    return await _preferences.setString(key, value);
  }

  Future<bool> setInt(String key, int value) async {
    return await _preferences.setInt(key, value);
  }

  Future<bool> setDouble(String key, double value) async {
    return await _preferences.setDouble(key, value);
  }

  //step6 ----> here Create functions to get :
  String? getString(String key) {
    return _preferences.getString(key);
  }

  bool? getBool(String key) {
    return _preferences.getBool(key);
  }

  int? getInt(String key) {
    return _preferences.getInt(key);
  }

  double? getDouble(String key) {
    return _preferences.getDouble(key);
  }

  //step6 ----> here Create functions to delete :
  remove(String key) async {
    await _preferences.remove(key);
  }

  clear() async {
    await _preferences.clear();
  }
}
