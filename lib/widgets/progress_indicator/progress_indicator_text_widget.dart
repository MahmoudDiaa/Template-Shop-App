import 'package:flutter/material.dart';

import '../../utils/locale/app_localization.dart';

class CustomProgressIndicatorTextWidget extends StatelessWidget {
  String? message;

  CustomProgressIndicatorTextWidget({Key? key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    this.message =
        this.message ?? AppLocalizations.of(context).translate('loading');
    return Align(
      alignment: Alignment.center,
      child: Container(
        height: 100,

        child: Center(
          child: Text(message ?? ''),
        ),
        //decoration: BoxDecoration(color: Color.fromARGB(100, 105, 105, 105)),
      ),
    );
  }
}
