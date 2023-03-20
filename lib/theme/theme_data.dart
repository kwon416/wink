import 'package:flutter/material.dart';

const seedColor = Color(0xff0099ff);
// const seedColor = Color(0xffff99ff);

ElevatedButtonThemeData elevatedButtonTheme = ElevatedButtonThemeData(
  style: ButtonStyle(
    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
      EdgeInsets.symmetric(horizontal: 40, vertical: 20)
    ),
    shape: MaterialStateProperty.all<OutlinedBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
  )
);
AppBarTheme appBarTheme = AppBarTheme(
  centerTitle: true,

);

ThemeData lightTheme = ThemeData(
  appBarTheme: appBarTheme,
  brightness: Brightness.light,
  colorScheme: ColorScheme.fromSeed(
    seedColor: seedColor,
    brightness: Brightness.light,
  ),
  elevatedButtonTheme: elevatedButtonTheme,
  iconTheme: IconThemeData(color: Colors.black),
);

ThemeData darkTheme = ThemeData(
  appBarTheme: appBarTheme,
  brightness: Brightness.dark,
  colorScheme: ColorScheme.fromSeed(
    seedColor: seedColor,
    brightness: Brightness.dark,
  ),
  elevatedButtonTheme: elevatedButtonTheme,
  iconTheme: IconThemeData(color: Colors.white),
);

