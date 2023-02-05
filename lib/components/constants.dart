import 'package:bmw/components/components.dart';
import 'package:flutter/material.dart';

import '../modules/login/shop_login_screen.dart';
import '../network/local/cache_helper.dart';


const defaultColor = Colors.deepOrange;

void signOut(
  context,
) {
  CacheHelper.clearData(key: 'token').then((value) {
    if (value) {
      navigateAndFinish(context, ShopLoginScreen());
    }
  });
}

void printFullText(String text) {
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((element) =>
    print(element.group(0))
  );
}

String token='';
String uId='';
