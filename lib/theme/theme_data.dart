import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:wink/utils/colors.dart';


import '../utils/constant.dart';

// const seedColor = Color(0xff0099ff);
// const seedColor = Color(0xffff99ff);
const seedColor = Colors.white;

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
  // centerTitle: true,
  // titleTextStyle: TextStyle(fontSize: textSizeNormal),
  // backgroundColor: Colors.transparent,
  elevation: 0,
);

IconThemeData iconThemeData = IconThemeData(
    size: iconSizeMedium,
);

TextTheme textTheme = TextTheme(
  bodyMedium: TextStyle(fontSize: textSizeMedium),
);

CheckboxThemeData checkboxTheme = CheckboxThemeData(
  overlayColor: MaterialStateProperty.all<Color?>(Colors.transparent),
  splashRadius: 0,
);

ToggleButtonsThemeData toggleButtonsTheme = ToggleButtonsThemeData(
  borderRadius: BorderRadius.circular(circularRadius),
  splashColor: transparent,
  constraints: BoxConstraints(

  ),
);



const scaffoldBackgroundColor = Colors.transparent;


ColorScheme whiteColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: black,
    onPrimary: white,
    primaryContainer: white,
    onPrimaryContainer: black,
    secondary: Colors.black12,
    onSecondary: white,
    error: Colors.red,
    onError: black,
    background: black,
    onBackground: white,
    surface: black,
    onSurface: white);
ColorScheme blackColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: white,
    onPrimary: black,
    primaryContainer: black,
    onPrimaryContainer: white,
    secondary: Colors.black12,
    onSecondary: white,
    error: Colors.red,
    onError: black,
    background: white,
    onBackground: black,
    surface: white,
    onSurface: black);

///밝은 테마 데이터
ThemeData lightTheme = ThemeData(
  splashFactory: NoSplash.splashFactory,
  splashColor: transparent,
  shadowColor: transparent,
  highlightColor: transparent,
  appBarTheme: appBarTheme.copyWith(
      iconTheme: iconThemeData.copyWith(color: black),
      titleTextStyle: TextStyle(color: black, fontSize: textSizeNormal,fontWeight: fontWeightBoldGlobal),
  ),
  scaffoldBackgroundColor: scaffoldBackgroundColor,
  brightness: Brightness.light,
  colorScheme: ColorScheme.fromSeed(seedColor: seedColor, brightness: Brightness.light,),
  // colorScheme: whiteColorScheme,
  elevatedButtonTheme: elevatedButtonTheme,
  iconButtonTheme: iconButtonTheme,
  iconTheme: IconThemeData(
      color: Colors.black,
  ),
  checkboxTheme: checkboxTheme,
  textTheme: textTheme,
  toggleButtonsTheme: toggleButtonsTheme,
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
  splashFactory: NoSplash.splashFactory,
  splashColor: transparent,
  shadowColor: transparent,
  highlightColor: transparent,
  appBarTheme: appBarTheme.copyWith(
    iconTheme: iconThemeData.copyWith(color: white),
    titleTextStyle: TextStyle(color: white, fontSize: textSizeNormal, fontWeight: fontWeightBoldGlobal)
  ),
  scaffoldBackgroundColor: scaffoldBackgroundColor,
  brightness: Brightness.dark,
  colorScheme: ColorScheme.fromSeed(seedColor: seedColor, brightness: Brightness.dark,),
  // colorScheme: blackColorScheme,
  elevatedButtonTheme: elevatedButtonTheme,
  iconButtonTheme: iconButtonTheme,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  iconTheme: IconThemeData(
      color: Colors.white
  ),
  checkboxTheme: checkboxTheme,
  textTheme: textTheme,
  toggleButtonsTheme: toggleButtonsTheme,
  // toggleButtonsTheme: toggleButtonsTheme,
).copyWith(
  pageTransitionsTheme: PageTransitionsTheme(builders: const <TargetPlatform, PageTransitionsBuilder>{
    TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
    TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    TargetPlatform.linux: OpenUpwardsPageTransitionsBuilder(),
    TargetPlatform.macOS: OpenUpwardsPageTransitionsBuilder(),
  }),
);

