import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';



void showToast(String message, BuildContext context) {
  TextTheme textTheme = Theme.of(context).textTheme;
  ColorScheme colorScheme = Theme.of(context).colorScheme;
  Fluttertoast.cancel();
  Fluttertoast.showToast(
    msg: message,
    textColor: colorScheme.onSecondary,
    fontSize: textTheme.titleLarge?.fontSize,
    backgroundColor: colorScheme.secondary,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
  );
}