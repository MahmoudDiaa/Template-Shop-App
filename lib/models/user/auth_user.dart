import 'package:boilerplate/models/user/user.dart';

class AuthUser {
  int? expiresIn;

  String? access_token;
  User? user;



  AuthUser({
    this.expiresIn,
    this.access_token,
    this.user,
  });

  factory AuthUser.fromMap(Map<String, dynamic> json) => AuthUser(
        expiresIn: json['expiresIn'],
        access_token: json['access_token'],
        user: json['user'] == null ? null : User.fromLoginMap(json['user']),
      );

  Map<String, dynamic> toMap() => {
        "expiresIn": expiresIn,
        "access_token": access_token,
        "user": user?.toMap()
      };
}
