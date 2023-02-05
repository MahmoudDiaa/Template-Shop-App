import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

import '../components/constants.dart';

ThemeData darkTheme = ThemeData(
    textTheme:  const TextTheme(
      bodyLarge: TextStyle(
        fontFamily: 'Jannah',
        fontSize: 18.0,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      titleMedium: TextStyle(
        fontFamily: 'Jannah',
        fontSize: 14.0,
        height: 1.5,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    ),
    primarySwatch: defaultColor,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: defaultColor,
        backgroundColor: HexColor('333739'),
        elevation: 20.0),
    appBarTheme: AppBarTheme(
      iconTheme: const IconThemeData(color: Colors.white),
      titleTextStyle: const TextStyle(
        fontFamily: 'Jannah',
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 20.0,
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: HexColor('333739'),
          statusBarBrightness: Brightness.light),
      backgroundColor: HexColor('333739'),
      elevation: 0.0,
    ),
    scaffoldBackgroundColor: HexColor('333739'));

ThemeData lightTheme = ThemeData(
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        fontFamily: 'Jannah',
        fontSize: 18.0,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
      titleMedium: TextStyle(
        fontFamily: 'Jannah',
        fontSize: 14.0,
        height: 1.5,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
    ),
    primarySwatch: defaultColor,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: defaultColor,
        elevation: 20.0),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(color: Colors.black),
      titleTextStyle: TextStyle(
        fontFamily: 'Jannah',
        color: Colors.black,
        fontWeight: FontWeight.w600,
        fontSize: 20.0,
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarBrightness: Brightness.dark,
      ),
      color: Colors.white,
      elevation: 0.0,
    ));
