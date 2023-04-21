import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:wink/utils/colors.dart';


import '../utils/constant.dart';

const seedColor = Color(0xff0099ff);
// const seedColor = Color(0xffff99ff);

IconButtonThemeData iconButtonTheme = IconButtonThemeData(
  style: ButtonStyle(
    //눌렀을 때 그림자 색
    shadowColor: MaterialStateProperty.all<Color?>(Colors.transparent),
    //눌렀을 때 퍼지는 스플래시 효과
    splashFactory: NoSplash.splashFactory,
  ),
);

ElevatedButtonThemeData elevatedButtonTheme = ElevatedButtonThemeData(
  style: ButtonStyle(
    //눌렀을 때 퍼지는 색
    overlayColor: MaterialStateProperty.all<Color?>(Colors.transparent),
    //눌렀을 때 그림자 색
    shadowColor: MaterialStateProperty.all<Color?>(Colors.transparent),
    //눌렀을 때 퍼지는 스플래시 효과
    splashFactory: NoSplash.splashFactory,
    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
      EdgeInsets.symmetric(horizontal: buttonPadding, vertical: buttonPadding)
    ),
    shape: MaterialStateProperty.all<OutlinedBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    ),
    textStyle: MaterialStateProperty.all<TextStyle>(
      TextStyle(
        fontSize: textSizeMedium,
      )
    ),
  )
);
AppBarTheme appBarTheme = AppBarTheme(
  centerTitle: true,
  // titleTextStyle: TextStyle(fontSize: textSizeNormal),
  // backgroundColor: Colors.transparent,
  elevation: 0.3,
);

IconThemeData iconThemeData = IconThemeData(
    size: iconSizeMedium,
);

TextTheme textTheme = TextTheme(
  bodyMedium: TextStyle(fontSize: textSizeMedium),
);

const scaffoldBackgroundColor = Colors.transparent;

///밝은 테마 데이터
ThemeData lightTheme = ThemeData(
  splashColor: transparent,
  shadowColor: transparent,
  highlightColor: transparent,
  appBarTheme: appBarTheme.copyWith(
      iconTheme: iconThemeData.copyWith(color: black),
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
  textTheme: textTheme,
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
    iconTheme: iconThemeData.copyWith(color: white),
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
  iconTheme: IconThemeData(
      color: Colors.white
  ),
  textTheme: textTheme,
).copyWith(
  pageTransitionsTheme: PageTransitionsTheme(builders: const <TargetPlatform, PageTransitionsBuilder>{
    TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
    TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    TargetPlatform.linux: OpenUpwardsPageTransitionsBuilder(),
    TargetPlatform.macOS: OpenUpwardsPageTransitionsBuilder(),
  }),
);

