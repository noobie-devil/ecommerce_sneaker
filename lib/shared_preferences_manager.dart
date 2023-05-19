
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:synchronized/synchronized.dart';

import 'models/models.dart';

class SharedPreferencesManager {

  static SharedPreferencesManager? _instance;
  static final _lock = Lock();
  // static Future<SharedPreferencesManager> _getInstance() {
  //   _instance ??= _init();
  //   return _instance;
  // }
  late final SharedPreferences _preferences;
  // static Future<SharedPreferencesManager?> get instance => _instance;

  SharedPreferencesManager._();

  static Future<SharedPreferencesManager> get instance {
      return SharedPreferencesManager._lock.synchronized(() async {
        print("SharedPreferenceManager instance");
        if(_instance != null) {
          return _instance!;
        } else {
          _instance = SharedPreferencesManager._();
          _instance?._preferences = await SharedPreferences.getInstance();
          return _instance!;
        }
      });
  }

  // SharedPreferencesManager._privateConstructor(SharedPreferences preferences) {
  //   _preferences = preferences;
  // }

  static Future<SharedPreferencesManager> _init() async {
    // _preferences = await SharedPreferences.getInstance();
    final manager = SharedPreferencesManager._();
    manager._preferences = await SharedPreferences.getInstance();
    return manager;
    // final preferences = await SharedPreferences.getInstance();
    // print("PreferenceManager:_init()");
    // return SharedPreferencesManager._privateConstructor(preferences);
  }

  // static Future<SharedPreferencesManager> getInstance() async {
  //   _instance ??= SharedPreferencesManager();
  //   _preferences ??= await SharedPreferences.getInstance();
  //   return _instance!;
  // }

  Future<bool> setString(String key, String value) async {
    return _preferences.setString(key, value);
  }

  String? getString(String key) {
    return _preferences.getString(key);
  }

  Future<bool> setInt(String key, int value) async {
    return _preferences.setInt(key, value);
  }

  int? getInt(String key) {
    return _preferences.getInt(key);
  }

  Future<bool> setBool(String key, bool value) async {
    return _preferences.setBool(key, value);
  }

  bool? getBool(String key) {
    return _preferences.getBool(key);
  }

  Future<bool> saveUser(User user) async {
    final String userJson = jsonEncode(user.toJson());
    print("saveUser: $userJson");
    bool result =  await _preferences.setString('current_user', userJson);
    print("result to saveUser: $result");
    return result;
  }

  Future<bool> clear() async {
    bool isClearedSuccess = await _preferences.clear();
    return isClearedSuccess;
  }

  User? getCurrentUser() {
    final String? userJson = _preferences.getString('current_user');
    print("getCurrentUser: $userJson");
    if(userJson != null) {
      final Map<String, dynamic> userMap = jsonDecode(userJson);
      return User.fromJson(userMap);
    }
    return null;
  }

  bool existsCurrentUser() {
    final bool exists = _preferences.containsKey('current_user');
    return exists;
  }
}