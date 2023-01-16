import '../../constants/strings.dart';

class User {
  String? fullName;

  String? userName;

  String? email;
  String? mobile;
  List? roles;

  bool? get isMqawel {
    return this.roles?.any((element) => element == RoleNames.Mqawel);
  }

  bool? get isIncidentEmployee {
    return this.roles?.any((element) => element == RoleNames.IncidentEmployee);
  }

  User({
    this.fullName,
    this.userName,
    this.email,
    this.mobile,
    this.roles,
  });

  factory User.fromLoginMap(Map<String, dynamic> json) => User(
      fullName: json['fullName'],
      userName: json['userName'],
      email: json['email'],
      mobile: json['mobile'],
      roles: json['roles']);

  Map<String, dynamic> toMap() => {
        "fullName": fullName,
        "userName": userName,
        "email": email,
        "mobile": mobile,
        "roles": roles,
      };
}
