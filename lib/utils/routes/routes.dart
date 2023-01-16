import 'package:boilerplate/ui/dashboard/dashboard_screen.dart';
import 'package:boilerplate/ui/login/login.dart';
import 'package:boilerplate/ui/sdad/incident_finally_sdad_screen.dart';
import 'package:boilerplate/ui/sdad/incident_sdad_screen.dart';
import 'package:boilerplate/ui/splash/splash.dart';
import 'package:flutter/material.dart';

import '../../constants/enums.dart';
import '../../ui/authentication/auth_screen.dart';
import '../../ui/create_incident/create_incident_step1.dart';
import '../../ui/home/categories.dart';
import '../../ui/home/home_screen.dart';

class Routes {
  Routes._();

  //static variables
  static const String splash = '/splash';
  static const String login = '/login';
  static const String signup = '/signup';

  static const String home = '/home';
  static const String categoryList = '/categoryList';
  static const String incidentFormStep1 = '/incidentFormStep1';
  static const String dashboard = '/dashboard';
  static const String changePassword = '/changePassword';
  static const String sdadScreen = '/sdadScreen';
  static const String finallysdadScreen = '/finallySdadScreen';

  static final routes = <String, WidgetBuilder>{
    splash: (BuildContext context) => SplashScreen(),
    login: (BuildContext context) =>
        AuthenticationScreen(authScreenMode: AuthScreenMode.Login),
    signup: (BuildContext context) => AuthenticationScreen(
          authScreenMode: AuthScreenMode.SignUp,
        ),
    changePassword: (BuildContext context) => AuthenticationScreen(
          authScreenMode: AuthScreenMode.ChangePassword,
        ),
    home: (BuildContext context) => HomeScreen(),
    categoryList: (BuildContext context) => CategoryListPage(),
    categoryList: (BuildContext context) => IncidentFormStep1(),
    dashboard: (BuildContext context) => DashboardScreen(),
    sdadScreen: (BuildContext context) => IncidentSdadScreen(),
    finallysdadScreen: (BuildContext context) => IncidentFinallySdadScreen(),
  };
}
