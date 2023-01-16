import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/sharedpref/constants/preferences.dart';
import '../../utils/locale/app_localization.dart';
import '../../utils/routes/routes.dart';
import '../constants/color_constants.dart';
import '../constants/colors.dart';
import '../constants/dimensions.dart';
import '../constants/strings.dart';

class SplashScreen2 extends StatefulWidget {
  @override
  _SplashScreen2State createState() => _SplashScreen2State();
}

class _SplashScreen2State extends State<SplashScreen2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorConstants.secondaryAppColor,
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                CustomColor.thirdColor,
                CustomColor.thirdColor,
                CustomColor.secondaryColor,
                CustomColor.secondaryColor
              ])),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/splash_logo.png',
                fit: BoxFit.cover,
                height: 115,
                width: 115,
              ),
              SizedBox(height: Dimensions.heightSize),
              Padding(
                padding: const EdgeInsets.only(
                    left: Dimensions.marginSize * 2,
                    right: Dimensions.marginSize * 2),
                child: Text(
                  Strings.appName,
                  style: TextStyle(
                      fontSize: Dimensions.largeTextSize * 1.4,
                      color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: Dimensions.heightSize * 6,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: Dimensions.marginSize * 2,
                    right: Dimensions.marginSize * 2),
                child: Text(
                    AppLocalizations.of(context).translate('loading'),
                  style: TextStyle(
                      fontSize: Dimensions.largeTextSize, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ));
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  startTimer() {
    var _duration = Duration(milliseconds: 2000);
    return Timer(_duration, navigate);
  }

  navigate() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    if (preferences.getBool(Preferences.is_logged_in) ?? false) {
      Navigator.of(context).pushReplacementNamed(Routes.dashboard);
    } else {
      Navigator.of(context).pushReplacementNamed(Routes.login);
    }
  }
}
