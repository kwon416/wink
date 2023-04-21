import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
// import 'package:home_hub/models/last_bookings_model.dart';
// import 'package:home_hub/screens/dashboard_screen.dart';
import 'package:wink/utils/colors.dart';

import 'constant.dart';
//텍스트 입력 폼
InputDecoration commonInputDecoration({String? hintText, Widget? prefixIcon, Widget? suffixIcon}) {
  return InputDecoration(
    filled: true,
    fillColor: textFieldColor,
    hintText: hintText,
    prefixIcon: prefixIcon,
    suffixIcon: suffixIcon,
    hintStyle: TextStyle(color: hintTextColor, fontSize: textSizeMedium),
    contentPadding: EdgeInsets.all(buttonPadding),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: BorderSide.none
    ),

  );
}

BoxDecoration boxDecorations({double radius = borderRadius, Color color = Colors.transparent, Color? bgColor, var showShadow = false}) {
  return BoxDecoration(
    color: bgColor,
    boxShadow: showShadow ? [BoxShadow(color: boxShadow, blurRadius: 10, spreadRadius: 2)] : [BoxShadow(color: Colors.transparent)],
    border: Border.all(color: color),
    borderRadius: BorderRadius.all(Radius.circular(radius)),
  );
}

BoxDecoration boxDecoration(
    {double radius = 80.0, Color backGroundColor = transparent, double blurRadius = 8.0, double spreadRadius = 8.0, Color radiusColor = Colors.black12, Gradient? gradient}) {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(radius),
    boxShadow: [
      BoxShadow(
        color: radiusColor,
        blurRadius: blurRadius,
        spreadRadius: spreadRadius,
      ),
    ],
    color: backGroundColor,
    gradient: gradient,
  );
}

// ignore: must_be_immutable
class SDButton extends StatefulWidget {
  static String tag = '/T4Button';
  var textContent;
  VoidCallback onPressed;
  var isStroked = false;
  var height = 40.0;

  SDButton({super.key, required this.textContent, required this.onPressed, this.isStroked = false, this.height = 45.0});

  @override
  SDButtonState createState() => SDButtonState();
}

class SDButtonState extends State<SDButton> {
  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme.apply(
      bodyColor: colorScheme.onPrimary,
      displayColor: colorScheme.onPrimary,
    );
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        // height: widget.height,
        padding: EdgeInsets.all(buttonPadding),
        alignment: Alignment.center,
        decoration: widget.isStroked ? boxDecorations(bgColor: Colors.transparent, color: colorScheme.primary) : boxDecorations(bgColor: colorScheme.primary, radius: borderRadius),
        child: Text(
          widget.textContent,
          textAlign: TextAlign.center,
          // style: boldTextStyle(size: 16, color: colorScheme.onPrimary, letterSpacing: 2),
          style: textTheme.labelMedium?.copyWith(fontSize: textSizeMedium),
        ),
      ),
    );
  }
}

settIngContainer({String? title, IconData? icon, Function? onTap, Color? textColor, Color? boxColor}) {
  return Container(
    padding: EdgeInsets.all(buttonPadding),
    margin: EdgeInsets.only(top: 8, bottom: 8),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(borderRadius), color: boxColor),
    child: Row(
      children: [Icon(icon), 16.width, Text(title!, style: TextStyle(color: textColor),)],
    ),
  ).onTap(onTap);
}

//
// Widget homeTitleWidget({
//   String? titleText,
//   String? viewAllText,
//   Function()? onAllTap,
// }) {
//   return Padding(
//     padding: EdgeInsets.symmetric(horizontal: 16),
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(titleText!, style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18)),
//         TextButton(
//           child: Text(
//             viewAllText ?? "View All",
//             style: TextStyle(color: viewAllColor, fontSize: 16, fontWeight: FontWeight.normal),
//           ),
//           onPressed: onAllTap!,
//         ),
//       ],
//     ),
//   );
// }
//
// Widget drawerWidget({String? drawerTitle, Function()? drawerOnTap, IconData? drawerIcon}) {
//   return ListTile(
//     horizontalTitleGap: 0,
//     visualDensity: VisualDensity.compact,
//     leading: Icon(drawerIcon!, size: 20),
//     title: Text(drawerTitle!, style: TextStyle()),
//     onTap: drawerOnTap!,
//   );
// }
//
// Future<void> showAlertDialog(BuildContext context, {int? index}) async {
//   return showDialog<void>(
//     context: context,
//     barrierDismissible: false, // user must tap button!
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: Text('Are you sure to book that service again?'),
//         actions: [
//           TextButton(
//             child: Text('No'),
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//           ),
//           TextButton(
//             child: Text('Yes'),
//             onPressed: () {
//               againBooking(index!);
//               Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => DashBoardScreen()), (route) => false);
//             },
//           ),
//         ],
//       );
//     },
//   );
// }
