import 'package:boilerplate/models/user/user.dart';
import 'package:sembast/sembast.dart';

import '../../models/user/auth_user.dart';
import '../local/constants/db_constants.dart';
import '../network/api_response.dart';
import '../network/apis/user/user_api.dart';
import '../sharedpref/shared_preference_helper.dart';

class UserRepository {
  // api objects
  final UserApi _userApi;

  // shared pref object
  final SharedPreferenceHelper _sharedPrefsHelper;

  UserRepository(this._userApi, this._sharedPrefsHelper);

  Future<LoginApiResponse?> login(username, password) async {
    // check to see if categories are present in database, then fetch from database
    // else make a network call to get all categories, store them into database for
    // later use
    var loginResponse = await _userApi.login(username, password).then((user) {
      // user.categories?.forEach((category) {
      //   _categoryDataSource.insert(category);
      // });

      return user;
    }).catchError((error) => throw error);
    return loginResponse;
  }

  Future<ApiResponse?> register(
      firstName, lastName, email, userName, password) async {
    var response = await _userApi
        .register(firstName, lastName, email, userName, password)
        .then((resposne) {
      return resposne;
    }).catchError((error) => throw error);
    return response;
  }

  Future<ApiResponse?> changePassword(currentPassword, password) async {
    var response = await _userApi
        .changePassword(currentPassword, password)
        .then((resposne) {
      return resposne;
    }).catchError((error) => throw error);
    return response;
  }

  Future<ApiResponse?> sendForgetPasswordLink(email) async {
    var response =
        await _userApi.sendForgetPasswordLink(email).then((resposne) {
      return resposne;
    }).catchError((error) => throw error);
    return response;
  }

  Future<ApiResponse?> resetPassword(code, email, password) async {
    var response =
        await _userApi.resetPassword(code, email, password).then((resposne) {
      return resposne;
    }).catchError((error) => throw error);
    return response;
  }

  Future<void> saveIsLoggedIn(bool value) =>
      _sharedPrefsHelper.saveIsLoggedIn(value);

  Future<void> saveLoggedInUser(AuthUser value) =>
      _sharedPrefsHelper.saveLoggedInUser(value);

  Future<void> removeLoggedInUser() => _sharedPrefsHelper.removeLoggedInUser();

  Future<bool> get isLoggedIn => _sharedPrefsHelper.isLoggedIn;
}
