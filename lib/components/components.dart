import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../cubit/cubit.dart';
import '../style/icon_broken.dart';
import 'constants.dart';

Widget defaultButton(
        {double width = double.infinity,
        Color background = defaultColor,
        double height = 50,
        required VoidCallback? function,
        required String text}) =>
    Container(
      width: width,
      height: height,

      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: background),
      child: MaterialButton(
        onPressed: function,
        child: Text(
          text.toUpperCase(),
          style: TextStyle(color: Colors.white),
        ),
      ),
    );

Widget defaultTextButton(
        {required VoidCallback? onPress, required String text}) =>
    TextButton(
      onPressed: onPress,
      child: Text(
        text.toUpperCase(),
      ),
    );

Widget defaultTextFormField(
        {required TextEditingController controller,
        required TextInputType textInputType,
        ValueChanged? onSubmit,
        ValueChanged? onChanged,
        FormFieldValidator? validate,
        required String label,
        required IconData prefix,
        bool obscure = false,
        VoidCallback? onTab,
        IconData? suffixIcon,
        bool isClickable = true,
        VoidCallback? onPressSuffix,
        TextInputAction textInputAction = TextInputAction.next}) =>
    TextFormField(
      controller: controller,
      keyboardType: textInputType,
      onFieldSubmitted: onSubmit,
      onChanged: onChanged,
      validator: validate,
      obscureText: obscure,
      onTap: onTab,
      textInputAction: textInputAction,
      enabled: isClickable,
      decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
          prefixIcon: Icon(prefix),
          suffixIcon:
              IconButton(onPressed: onPressSuffix, icon: Icon(suffixIcon))),
      style: TextStyle(fontSize: 20.0),
    );

Widget buildTaskItem({required Map model, required BuildContext context}) =>
    Dismissible(
      key: Key(model['id'].toString()),
      onDismissed: (direction) {
        AppCubit.get(context).deleteData(id: model['id']);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40.0,
              child: Text('${model['time']}'),
            ),
            SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model['title']}',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${model['date']}',
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
            IconButton(
              onPressed: () {
                AppCubit.get(context)
                    .updateData(status: 'done', id: model['id']);
              },
              icon: Icon(Icons.check_box_rounded, color: Colors.green),
              iconSize: 30.0,
            ),
            IconButton(
              onPressed: () {
                AppCubit.get(context)
                    .updateData(status: 'archive', id: model['id']);
              },
              icon: Icon(Icons.archive_rounded, color: Colors.red),
              iconSize: 30.0,
            )
          ],
        ),
      ),
    );



Widget divider({padding = const EdgeInsets.all(10)}) => Padding(
      padding: padding,
      child: Container(
        width: double.infinity,
        height: 1,
        color: Colors.grey[300],
      ),
    );



void navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context, MaterialPageRoute(builder: (context) => widget), (route) => false);

void showToast({required String message, required ToastStates states}) =>
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        fontSize: 16.0,
        timeInSecForIosWeb: 5,

        backgroundColor: chooseToastColor(states));

enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates states) {
  switch (states) {
    case ToastStates.SUCCESS:
      return Colors.green;
    case ToastStates.ERROR:
      return Colors.red;
    case ToastStates.WARNING:
      return Colors.amber;
  }
}

PreferredSizeWidget defaultAppBar(
        {required BuildContext context,
        String? title,
        List<Widget>? actions,}) =>
    AppBar(
      titleSpacing: 5,
      leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(IconBroken.Arrow___Left_2)),
      title: Text(title!),
      actions: actions,
    );
