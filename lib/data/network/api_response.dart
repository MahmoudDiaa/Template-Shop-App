import '../../models/user/auth_user.dart';

class ApiResponse {
  bool? success;
  String? message;

  ApiResponse({this.success, this.message});

  factory ApiResponse.fromMap(Map<String, dynamic> json) => ApiResponse(
        success: json['success'],
        message: json['message'],
      );

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['success'] = this.success;
    data['message'] = this.message;
    return data;
  }
}

class LoginApiResponse extends ApiResponse {
  LoginApiResponse(bool success, String message)
      : super(success: success, message: message);
  AuthUser? authUser;

  factory LoginApiResponse.fromMap(Map<String, dynamic> json) {
    var response = LoginApiResponse(
      json['success'],
      json['message'],
    );
    response.authUser = AuthUser.fromMap(json);
    return response;
  }
}
