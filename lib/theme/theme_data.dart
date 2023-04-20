import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:wink/utils/colors.dart';


import '../utils/constant.dart';

const seedColor = Color(0xff0099ff);
// const seedColor = Color(0xffff99ff);

IconButtonThemeData iconButtonTheme = IconButtonThemeData(
  style: ButtonStyle(
    shadowColor: MaterialStateProperty.all<Color?>(Colors.transparent),
    splashFactory: NoSplash.splashFactory,
  ),
);

ElevatedButtonThemeData elevatedButtonTheme = ElevatedButtonThemeData(
  style: ButtonStyle(
    overlayColor: MaterialStateProperty.all<Color?>(Colors.transparent),
    shadowColor: MaterialStateProperty.all<Color?>(Colors.transparent),
    splashFactory: NoSplash.splashFactory,
    //backgroundColor: MaterialStateProperty.all<Color>,
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

///밝은 테마 데이터
ThemeData lightTheme = ThemeData(
  splashColor: transparent,
  shadowColor: transparent,
  highlightColor: transparent,
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
  iconButtonTheme: iconButtonTheme,
  iconTheme: IconThemeData(
      color: Colors.black,
  ),
).copyWith(
  pageTransitionsTheme: PageTransitionsTheme(builders: const <TargetPlatform, PageTransitionsBuilder>{
    TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
    TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    TargetPlatform.linux: OpenUpwardsPageTransitionsBuilder(),
    TargetPlatform.macOS: OpenUpwardsPageTransitionsBuilder(),
  }),
);

///어두운 테마 데이터
ThemeData darkTheme = ThemeData(
  splashColor: transparent,
  shadowColor: transparent,
  highlightColor: transparent,
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
  iconButtonTheme: iconButtonTheme,
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

