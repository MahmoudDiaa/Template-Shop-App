import 'package:another_flushbar/flushbar_helper.dart';
import 'package:boilerplate/ui/authentication/signup_widget.dart';
import 'package:flutter/material.dart';

import '../../constants/enums.dart';
import '../../utils/locale/app_localization.dart';
import '../constants/colors.dart';
import 'change_password_widget.dart';
import 'login_widget.dart';

class AuthenticationScreen extends StatefulWidget {
  AuthScreenMode authScreenMode;

  String? initialPassword;
  String? initialUserName;

  AuthenticationScreen(
      {required this.authScreenMode,
      this.initialUserName,
      this.initialPassword});

  @override
  _AuthenticationScreenState createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  // ignore: close_sinks

  @override
  Widget build(BuildContext context) {
    _showError(String message) {
      if (message.isNotEmpty) {
        Future.delayed(Duration(milliseconds: 0), () {
          if (message.isNotEmpty) {
            FlushbarHelper.createError(
              message: message,
              title: AppLocalizations.of(context).translate('home_tv_error'),
              duration: Duration(seconds: 2),
            )..show(context);
          }
        });
      }

      return SizedBox.shrink();
    }

    return Scaffold(
        backgroundColor: CustomColor.primaryColor,
        body: WillPopScope(
          onWillPop: () async => false,
          child: widget.authScreenMode == AuthScreenMode.Login
              ? LoginFormWidget(
                  initialUserName: widget.initialUserName,
                  initialPassword: widget.initialPassword,
                )
              : widget.authScreenMode == AuthScreenMode.SignUp
                  ? SignUpFormWidget()
                  : widget.authScreenMode == AuthScreenMode.ChangePassword
                      ? ChangePasswordFormWidget()
                      : Text('No Auth Screen Mode!'),
        ));
  }

  @override
  void initState() {
    super.initState();
  }
}
