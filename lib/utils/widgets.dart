import 'package:flutter/material.dart';
// import 'package:home_hub/models/last_bookings_model.dart';
// import 'package:home_hub/screens/dashboard_screen.dart';
import 'package:wink/utils/colors.dart';
//
InputDecoration commonInputDecoration({String? hintText, Widget? prefixIcon, Widget? suffixIcon}) {
  return InputDecoration(
    filled: true,
    fillColor: textFieldColor,
    hintText: hintText,
    prefixIcon: prefixIcon,
    suffixIcon: suffixIcon,
    hintStyle: TextStyle(color: hintTextColor, fontSize: 16),
    contentPadding: EdgeInsets.symmetric(horizontal: 16),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
  );
}

BoxDecoration boxDecorations({double radius = 8, Color color = Colors.transparent, Color? bgColor, var showShadow = false}) {
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
      // bodyColor: colorScheme.onPrimaryContainer,
      // displayColor: colorScheme.onPrimaryContainer,
    );
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        height: widget.height,
        padding: EdgeInsets.fromLTRB(16, 4, 16, 4),
        alignment: Alignment.center,
        decoration: widget.isStroked ? boxDecorations(bgColor: Colors.transparent, color: colorScheme.primary) : boxDecorations(bgColor: colorScheme.primary, radius: 6),
        child: Text(
          widget.textContent,
          textAlign: TextAlign.center,
          // style: boldTextStyle(size: 16, color: colorScheme.onPrimary, letterSpacing: 2),
          style: textTheme.bodyLarge,
        ),
      ),
    );
  }
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
