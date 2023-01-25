import 'dart:convert';

import 'package:boilerplate/data/network/dio_client.dart';
import 'package:dio/dio.dart';

import '../../../../models/category/category_list.dart';
import '../../../../models/user/auth_user.dart';
import '../../../../models/user/user.dart';
import '../../../sharedpref/shared_preference_helper.dart';
import '../../api_response.dart';
import '../../constants/endpoints.dart';

class UserApi {
  final DioClient _dioClient;
  ApiResponse? apiResponse;
  SharedPreferenceHelper sharedPreferenceHelper;

  UserApi(this._dioClient, this.sharedPreferenceHelper);

  /// Returns list of category in response
  Future<LoginApiResponse?> login(username, password) async {
    try {
      final res = await _dioClient.post(Endpoints.login,
          data: jsonEncode({'userName': username, 'password': password}),
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
          ));
      return apiResponse = LoginApiResponse.fromMap(res);
      //return apiResponse!.success == true ? AuthUser.fromMap(res) : null;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<ApiResponse?> register(
      firstName, lastName, email, userName, password) async {
    try {
      final res = await _dioClient.post(
          '${Endpoints.signUp}?frontVerifyUrl=http://51.15.23.9:8085/auth/signin/verifyemail',
          data: jsonEncode({
            'UserName': userName,
            'Email': email,
            'Password': password,
            'Age': '11',
            'Gender': '1',
            'FullName': email,
            "firstName": firstName,
            "lastName": lastName,
            "roles": ["IncidentEmployee"]
          }),
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
          ));
      apiResponse = ApiResponse.fromMap(res);
      return apiResponse;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<ApiResponse?> changePassword(currentPassword, password) async {
    try {
      final res = await _dioClient.post(Endpoints.changePassword,
          data: jsonEncode({
            'currentPassword': currentPassword,
            'newPassword': password,
          }),
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Authorization':
                  'Bearer ${sharedPreferenceHelper.authUser?.access_token ?? ''}',
            },
          ));
      apiResponse = ApiResponse.fromMap(res);
      return apiResponse;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<ApiResponse?> sendForgetPasswordLink(email) async {
    try {
      final res = await _dioClient.post(Endpoints.forgetPasswordLink,
          data: jsonEncode({
            'email': email,
          }),
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
          ));
      apiResponse = ApiResponse.fromMap(res);
      return apiResponse;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<ApiResponse?> resetPassword(code, email, password) async {
    try {
      final res = await _dioClient.post(Endpoints.resetPassword,
          data: jsonEncode({
            'code': code,
            'email': email,
            'password': password,
          }),
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
          ));
      apiResponse = ApiResponse.fromMap(res);
      return apiResponse;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
