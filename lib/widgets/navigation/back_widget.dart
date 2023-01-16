import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../data/repository.dart';
import '../../stores/language/language_store.dart';
import '../../ui/constants/colors.dart';
import '../../ui/constants/dimensions.dart';
import '../../utils/locale/app_localization.dart';

class BackWidget extends StatefulWidget {
  @override
  _BackWidgetState createState() => _BackWidgetState();
}

class _BackWidgetState extends State<BackWidget> {
  final LanguageStore _languageStore =
      LanguageStore(GetIt.instance<Repository>());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          right: Dimensions.marginSize,
          top: Dimensions.heightSize * 5,
          bottom: Dimensions.heightSize * 3),
      child: GestureDetector(
        child: Container(
            width: 110,
            color: CustomColor.primaryColor.withOpacity(0.7),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  Text(
                    AppLocalizations.of(context).translate('back'),
                    style: TextStyle(
                        color: Colors.white, fontSize: Dimensions.largeTextSize),
                  )
                ],
              ),
            )),
        onTap: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
