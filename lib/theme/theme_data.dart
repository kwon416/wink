import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';

import 'package:wink/utils/colors.dart';

import '../utils/constant.dart';

const seedColor = Color(0xff0099ff);
// const seedColor = Color(0xffff99ff);

ElevatedButtonThemeData elevatedButtonTheme = ElevatedButtonThemeData(
  style: ButtonStyle(
    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
      EdgeInsets.symmetric(horizontal: 20, vertical: 20)
    ),
    shape: MaterialStateProperty.all<OutlinedBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    ),
  )
);
AppBarTheme appBarTheme = AppBarTheme(
  centerTitle: true,
  // titleTextStyle: TextStyle(fontSize: textSizeNormal),
  // backgroundColor: Colors.transparent,
  elevation: 0.3,
);

const scaffoldBackgroundColor = Colors.transparent;

ThemeData lightTheme = ThemeData(
  appBarTheme: appBarTheme.copyWith(
      iconTheme: IconThemeData(color: black),
      titleTextStyle: TextStyle(color: black, fontSize: textSizeNormal),
  ),
  scaffoldBackgroundColor: scaffoldBackgroundColor,
  brightness: Brightness.light,
  colorScheme: ColorScheme.fromSeed(
    seedColor: seedColor,
    brightness: Brightness.light,
  ),
  elevatedButtonTheme: elevatedButtonTheme,
  iconTheme: IconThemeData(color: Colors.black),
).copyWith(
  pageTransitionsTheme: PageTransitionsTheme(builders: const <TargetPlatform, PageTransitionsBuilder>{
    TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
    TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    TargetPlatform.linux: OpenUpwardsPageTransitionsBuilder(),
    TargetPlatform.macOS: OpenUpwardsPageTransitionsBuilder(),
  }),
);

ThemeData darkTheme = ThemeData(
  appBarTheme: appBarTheme.copyWith(
    iconTheme: IconThemeData(color: white),
    titleTextStyle: TextStyle(color: white, fontSize: textSizeNormal, fontWeight: fontWeightBoldGlobal)
  ),
  scaffoldBackgroundColor: scaffoldBackgroundColor,
  brightness: Brightness.dark,
  colorScheme: ColorScheme.fromSeed(
    seedColor: seedColor,
    brightness: Brightness.dark,
  ),
  elevatedButtonTheme: elevatedButtonTheme,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  iconTheme: IconThemeData(color: Colors.white),
).copyWith(
  pageTransitionsTheme: PageTransitionsTheme(builders: const <TargetPlatform, PageTransitionsBuilder>{
    TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
    TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    TargetPlatform.linux: OpenUpwardsPageTransitionsBuilder(),
    TargetPlatform.macOS: OpenUpwardsPageTransitionsBuilder(),
  }),
);

