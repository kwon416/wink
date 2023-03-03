import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';



void showToast(String message, BuildContext context) {
  TextTheme textTheme = Theme.of(context).textTheme;
  ColorScheme colorScheme = Theme.of(context).colorScheme;
  Fluttertoast.showToast(
    msg: message,
    textColor: colorScheme.onSurfaceVariant,
    fontSize: textTheme.titleLarge?.fontSize,
    backgroundColor: colorScheme.surfaceVariant,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
  );
}