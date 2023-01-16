import 'dart:async';
import 'dart:convert';

import 'package:boilerplate/models/user/auth_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants/preferences.dart';

class SharedPreferenceHelper {
  // shared pref instance
  final SharedPreferences _sharedPreference;

  // constructor
  SharedPreferenceHelper(this._sharedPreference);

  // General Methods: ----------------------------------------------------------
  Future<String?> get authToken async {
    return _sharedPreference.getString(Preferences.auth_token);
  }

  Future<bool> saveAuthToken(String authToken) async {
    return _sharedPreference.setString(Preferences.auth_token, authToken);
  }

  Future<bool> removeAuthToken() async {
    return _sharedPreference.remove(Preferences.auth_token);
  }

  // Login:---------------------------------------------------------------------
  Future<bool> get isLoggedIn async {
    return _sharedPreference.getBool(Preferences.is_logged_in) ?? false;
  }

  Future<bool> saveIsLoggedIn(bool value) async {
    return _sharedPreference.setBool(Preferences.is_logged_in, value);
  }

  // User:----------------------------------------------------------------
  Future<bool> saveLoggedInUser(AuthUser authUser) async {
    Map<String, dynamic> user = authUser.toMap();

    return _sharedPreference.setString(Preferences.auth_user, jsonEncode(user));
  }

  Future<bool> removeLoggedInUser() async {
    saveIsLoggedIn(false);
    return _sharedPreference.remove(Preferences.auth_user);
  }

  AuthUser? get authUser {
    if (_sharedPreference.getString(Preferences.auth_user) == null) return null;
    Map<String, dynamic> userMap =
        jsonDecode(_sharedPreference.getString(Preferences.auth_user)!);
    return AuthUser.fromMap(userMap);
  }

  // Theme:------------------------------------------------------
  bool get isDarkMode {
    return _sharedPreference.getBool(Preferences.is_dark_mode) ?? false;
  }

  Future<void> changeBrightnessToDark(bool value) {
    return _sharedPreference.setBool(Preferences.is_dark_mode, value);
  }

  // Language:---------------------------------------------------
  String? get currentLanguage {
    return _sharedPreference.getString(Preferences.current_language);
  }

  Future<void> changeLanguage(String language) {
    return _sharedPreference.setString(Preferences.current_language, language);
  }
}
