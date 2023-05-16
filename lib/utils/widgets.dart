import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:wink/controller/membership_controller.dart';
// import 'package:home_hub/models/last_bookings_model.dart';
// import 'package:home_hub/screens/dashboard_screen.dart';
import 'package:wink/utils/colors.dart';
import 'package:wink/utils/images.dart';

import 'space.dart';
import 'constant.dart';

///공통 텍스트 입력 폼
InputDecoration commonInputDecoration({String? labelText, String? hintText, Widget? prefixIcon, Widget? suffixIcon}) {
  return InputDecoration(
    filled: true,
    fillColor: textFieldColor,
    hintText: hintText,
    labelText: labelText,
    prefixIcon: prefixIcon,
    suffixIcon: suffixIcon,
    hintStyle: TextStyle(color: hintTextColor, fontSize: textSizeMedium),
    labelStyle: TextStyle(color: hintTextColor, fontSize: textSizeMedium),
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

///ElevatedButton 대체 버튼
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

///바텀 바 위치에 넣는 버튼
// ignore: must_be_immutable
class BottomElevatedButton extends StatefulWidget {
  var textContent;
  VoidCallback onPressed;

  BottomElevatedButton({super.key, required this.textContent, required this.onPressed});

  @override
  State<BottomElevatedButton> createState() => _BottomElevatedButtonState();
}

class _BottomElevatedButtonState extends State<BottomElevatedButton> {
  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme.apply(
      bodyColor: colorScheme.onPrimary,
      displayColor: colorScheme.onPrimary,
    );
    return ElevatedButton(
        onPressed: widget.onPressed,
        style: ButtonStyle(
          shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(circularRadius),
            ),
          ),
        ),
        child: Text(
          widget.textContent,
          textAlign: TextAlign.center,
          // style: boldTextStyle(size: 16, color: colorScheme.onPrimary, letterSpacing: 2),
          style: textTheme.labelMedium?.copyWith(fontSize: textSizeMedium),
        ),
    );
  }
}

///프로필 스크린 컨테이너
settIngContainer({String? title, IconData? icon, Function? onTap, Color? textColor, Color? boxColor}) {
  return Container(
    padding: EdgeInsets.all(buttonPadding),
    margin: EdgeInsets.symmetric(vertical: buttonMargin),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(borderRadius), color: boxColor),
    child: Row(
      children: [
        Icon(icon, color: textColor,),
        Space(buttonPadding),
        Text(title!, style: TextStyle(color: textColor),)],
    ),
  ).onTap(onTap);
}

///토글 버튼에 사용하는 디자인 컨테이너
Widget toggleContainer(String value, ColorScheme colorScheme, bool isSelected) {
  return Container(
    constraints: BoxConstraints(
      minWidth: Get.width / 5,
    ),
    padding: EdgeInsets.all(1),
    margin: EdgeInsets.all(2),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(circularRadius),
        color: isSelected ? colorScheme.primary : transparent
    ),
    child: Center(
      child: Text(value),
    ),
  );
}

///OS별 스위치 버튼 디자인
Switch customAdaptiveSwitch(
    {required bool value, required Function(bool newValue) onChanged, Color? activeColor, Color? activeTrackColor}) {
  return Switch.adaptive(
    value: value,
    onChanged: onChanged,
    activeColor: activeColor ?? Colors.white,
    activeTrackColor: activeColor ?? Colors.white,
    inactiveTrackColor: Colors.grey,
    // activeTrackColor: activeTrackColor ?? Colors.grey,
  );
}

///앱 테마 다이얼로그
void showAppDialog(String title, String middleText) {
  Get.defaultDialog(
    title: title,
    middleText: middleText,
    radius: borderRadius,

  );
}

///앱 테마 스낵바
///awesome_snackbar 고려
void showAppSnackBar(String title, String message, {SnackPosition? snackPosition}) {
  Get.closeCurrentSnackbar();
  Get.snackbar(
    title,
    message,
    backgroundColor: white,
    snackPosition: snackPosition ?? SnackPosition.BOTTOM,
    margin: EdgeInsets.all(appPadding),
    padding: EdgeInsets.all(buttonPadding),
    borderRadius: borderRadius,
    // leftBarIndicatorColor: Colors.black,
    // icon: Icon(Icons.abc)
  );
}

///안드로이드에서 사용하는 빈 화면
Widget appEmptyWidget(String image, String? title, String? text) {
  return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: SizedBox(
            height: constraints.maxHeight,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(image, width: 200,),
                  Space(buttonMargin),
                  Text(title??'', style: TextStyle(fontSize: textSizeLarge, fontWeight: FontWeight.bold),),
                  Space(buttonMargin),
                  Text(text??'',style: TextStyle(fontSize: textSizeMedium)),
                ],
              ),
            ),
          ),
        );
      }
  );
}

///플랫폼 별 refresh Indicator
class CustomRefreshIndicator extends StatelessWidget {
  CustomRefreshIndicator({
    super.key,
    required this.itemCount,
    required this.onRefresh,
    required this.builder,
    this.emptyMessageTitle,
    this.emptyMessageBody,
});

  final int itemCount;
  final Future<void> Function() onRefresh;
  final Widget Function(BuildContext context, int index) builder;
  final String? emptyMessageTitle;
  final String? emptyMessageBody;

  @override
  Widget build(BuildContext context) {
    if (GetPlatform.isIOS) {
      return CustomScrollView(
        physics: AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        slivers: [
          CupertinoSliverRefreshControl(
            refreshTriggerPullDistance: 100.0,
            refreshIndicatorExtent: 3.0,
            onRefresh: onRefresh,
          ),
          itemCount == 0
          ?SliverFillRemaining(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(splashLogo, width: 200,),
                  Space(buttonMargin),
                  Text(emptyMessageTitle??"", style: TextStyle(fontSize: textSizeLarge, fontWeight: FontWeight.bold),),
                  Space(buttonMargin),
                  Text(emptyMessageBody??"",style: TextStyle(fontSize: textSizeMedium)),
                ],
              ),
            ),
          )
          :SliverList(
            delegate: SliverChildBuilderDelegate(
              builder,
              childCount: itemCount,
            ),
          ),

        ],
      );
    } else {
      return RefreshIndicator(
        onRefresh: onRefresh,
        child: itemCount != 0
            ?ListView.builder(
          itemCount: itemCount,
          physics: AlwaysScrollableScrollPhysics(
            // parent: BouncingScrollPhysics()
          ),
          itemBuilder: builder,
        )
        :appEmptyWidget(splashLogo, emptyMessageTitle, emptyMessageBody),
      );
    }
  }

}

///인앱결제 바텀 모달 시트
void purchaseBottomSheet(BuildContext context) {
  const double price = 1000;
  var priceFormat = NumberFormat.currency(locale: Get.locale.toString(), symbol: '₩');

  showModalBottomSheet(
    shape: RoundedRectangleBorder(borderRadius: radiusOnly(topLeft: borderRadius, topRight: borderRadius)),
    context: context,
    isScrollControlled: true,
    builder: (builder) {
      ColorScheme colorScheme = Theme.of(context).colorScheme;
      return GetBuilder<MembershipController>(
        builder: (controller) {
          return SizedBox(
            height: Get.height *0.8,
            child: Scaffold(
              appBar: AppBar(
                centerTitle: true,
                leading: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.close, size: 30)
                ),
                title: Text('코인'),
                actions: [
                  TextButton(
                    onPressed: () {},
                    child: Text('사용 내역')
                  ),
                ],
              ),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Space(buttonMargin),
                    Image.asset(icHeart, height: iconSizeXLarge,),
                    Space(buttonMargin),
                    Text('${controller.userData?.coin} ${'코인'.tr}', style: TextStyle(fontSize: textSizeNormal, fontWeight: FontWeight.bold),),
                    Space(buttonMargin),
                    Text(
                      '현재 보유 코인',
                      style: secondaryTextStyle(),
                    ),
                    Space(buttonMargin),
                    Divider(thickness: 1),
                    Padding(
                      padding: EdgeInsets.all(appPadding),
                      child: Column(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              // 결제 로직을 구현하세요.
                              // 사용자가 버튼을 눌렀을 때 호출되는 함수입니다.
                              // 여기에 결제 처리 코드를 작성하세요.
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(icHeart, height: 24,),
                                    Space(buttonPadding),
                                    Text('무료 코인'),
                                  ],
                                ),
                                FaIcon(FontAwesomeIcons.rectangleAd),
                              ],
                            ),
                          ),
                          Space(buttonMargin),
                          ElevatedButton(
                            onPressed: () {
                              // 결제 로직을 구현하세요.
                              // 사용자가 버튼을 눌렀을 때 호출되는 함수입니다.
                              // 여기에 결제 처리 코드를 작성하세요.
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(icHeart, height: 24,),
                                    Space(buttonPadding),
                                    Text('10 코인'),
                                  ],
                                ),
                                Text(priceFormat.format(1100)),
                              ],
                            ),
                          ),
                          Space(buttonMargin),
                          ElevatedButton(
                            onPressed: () {
                              // 결제 로직을 구현하세요.
                              // 사용자가 버튼을 눌렀을 때 호출되는 함수입니다.
                              // 여기에 결제 처리 코드를 작성하세요.
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(icHeart, height: 24,),
                                    Space(buttonPadding),
                                    Text('30 코인'),
                                  ],
                                ),
                                Text(priceFormat.format(2200)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      );
    },
  );
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
