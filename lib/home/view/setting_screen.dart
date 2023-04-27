import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:wink/theme/theme_data.dart';
import 'package:wink/utils/constant.dart';
import 'package:wink/utils/widgets.dart';
// import 'package:prokit_flutter/fullApps/flixv2/model/setting_model.dart';
// import 'package:prokit_flutter/fullApps/flixv2/utils/common_widgets.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  State<SettingScreen> createState() => SettingScreenState();
}

class SettingScreenState extends State<SettingScreen> {
  List<String> title = ['일반', 'Cache', '기타'];
  List<String> generalSettings = ['언어 변경', 'Stream Quality', '알림 설정', '다크 모드'];

  bool mode = true;
  bool notifications = true;
  bool isDarkMode = false;
  bool enableCache = true;
  List<IconData> generalSettingsIconList = [
    Icons.translate_rounded,
    Icons.wifi,
    Icons.notifications,
    Icons.change_circle_rounded
  ];
  List<String> cacheList = ['Enable cache', 'Clear cache'];
  List<IconData> leadingcatchIconList = [Icons.square_rounded, Icons.cleaning_services_rounded];
  List<String> otherSetings = ['Privacy Policy', 'Security Notifications'];
  List<IconData> otherSetingsLeadingIcon = [
    Icons.privacy_tip,
    Icons.notifications,
  ];

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme.apply(
      // bodyColor: colorScheme.onPrimaryContainer,
      // displayColor: colorScheme.onPrimaryContainer,
    );



    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.primaryContainer,
        title: Text("설정"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      backgroundColor: colorScheme.primaryContainer,
      body: Padding(
        padding: EdgeInsets.all(appPadding),
        child: Center(
          child: RefreshIndicator(
            onRefresh: () async {
              Get.defaultDialog();
            },
            child: SingleChildScrollView(
              child: Wrap(
                direction: Axis.vertical,
                spacing: appPadding,
                children: [
                  Wrap(
                    spacing: appPadding,
                    direction: Axis.vertical,
                    children: [
                      Text(
                        title[0],
                        style: boldTextStyle(size: textSizeNormal.toInt(), color: colorScheme.onPrimaryContainer),
                      ),
                      Wrap(
                        spacing: buttonMargin*2,
                        direction: Axis.vertical,
                        children: List.generate(generalSettings.length, (index) {
                          return generalSettingsComponent(index);
                        }),
                      )
                    ],
                  ),
                  Wrap(
                    spacing: appPadding,
                    direction: Axis.vertical,
                    children: [
                      Text(
                        title[1],
                        style: boldTextStyle(size: textSizeNormal.toInt(), color: colorScheme.onPrimaryContainer),
                      ),
                      // SizedBox(height: 14),
                      // Container(
                      //   height: 6,
                      //   width: MediaQuery.of(context).size.width - appPadding*2,
                      //   decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: context.cardColor),
                      // ),
                      // SizedBox(height: 8),
                      // Row(
                      //   children: [
                      //     Text(
                      //       'Used  2.4GB',
                      //       style: secondaryTextStyle(size: 12),
                      //     ),
                      //     SizedBox(width: MediaQuery.of(context).size.width / 2 + 32),
                      //     Text('Free 6.0GB', style: secondaryTextStyle(size: 12)),
                      //   ],
                      // ),
                      Wrap(
                        spacing: buttonMargin*2,
                        direction: Axis.vertical,
                        children: List.generate(cacheList.length, (index) {
                          return cacheSettings(index);
                        }),
                      )
                    ],
                  ),
                  Wrap(
                    spacing: appPadding,
                    direction: Axis.vertical,
                    children: [
                      Text(
                        title[2],
                        style: boldTextStyle(size: textSizeNormal.toInt(), color: colorScheme.onPrimaryContainer),
                      ),
                      Wrap(
                        spacing: buttonMargin*2,
                        direction: Axis.vertical,
                        children: List.generate(otherSetings.length, (index) {
                          return otherSettings(index);
                        }),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  generalSettingsComponent(int index) {
    List trailingIcons = [
      TextButton(
        onPressed: () {},
        style: ButtonStyle(
          padding: MaterialStatePropertyAll(EdgeInsets.zero),
          visualDensity: VisualDensity.compact,
        ),
        child: Text(
          '한국어',
          style: secondaryTextStyle(color: Get.isDarkMode?black:white),
        ),
      ),
      TextButton(
        onPressed: () {},
        style: ButtonStyle(
          padding: MaterialStatePropertyAll(EdgeInsets.zero),
          visualDensity: VisualDensity.compact,
        ),
        child: Text(
          'Full HD',
          style: secondaryTextStyle(color: Get.isDarkMode?black:white),
        ),
      ),
      customAdaptiveSwitch(
        value: notifications,
        onChanged: (newValue) {
          notifications = !notifications;
          setState(() {});
        },
      ),
      customAdaptiveSwitch(
        value: Get.isDarkMode,
        onChanged: (newValue) {
          // isDarkMode = !isDarkMode;
          Get.changeTheme(Get.isDarkMode? lightTheme : darkTheme);
          setState(() {});
        },
      ),
    ];
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width - appPadding*2,
        padding: EdgeInsets.only(left: buttonPadding, right: buttonPadding),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(generalSettingsIconList[index], color: Get.isDarkMode?black:white),
            SizedBox(width: buttonPadding),
            Expanded(
              child: Text(
                generalSettings[index],
                style: primaryTextStyle(color: Theme.of(context).colorScheme.onPrimary),
              ),
            ),
            SizedBox(
              child: trailingIcons[index],
            )
          ],
        ),
      ),
    );
  }

  cacheSettings(int index) {
    return Container(
        width: MediaQuery.of(context).size.width - appPadding*2,
        padding: EdgeInsets.all(buttonPadding),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              leadingcatchIconList[index],
              color: Get.isDarkMode?black:white,
            ),
            SizedBox(width: buttonPadding),
            Expanded(
              child: Text(
                cacheList[index],
                style: primaryTextStyle(color: Theme.of(context).colorScheme.onPrimary),
              ),
            ),
            index == 0
                ? SizedBox(height: 24,
                  child: Switch(
                  value: enableCache,
                  activeTrackColor: Colors.red,
                  activeColor: Colors.white,
                  onChanged: (newvalue) {
                    enableCache = !enableCache;
                    setState(() {});
                  }),
                )
                : Offstage(),
          ],
        ));
  }

  otherSettings(int index) {

    return Container(
        width: MediaQuery.of(context).size.width - appPadding*2,
        padding: EdgeInsets.all(
          buttonPadding
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              otherSetingsLeadingIcon[index],
                color: Get.isDarkMode?black:white,
            ),
            SizedBox(width: buttonPadding),
            Expanded(
              child: Text(
                otherSetings[index],
                style: primaryTextStyle(color: Theme.of(context).colorScheme.onPrimary),
              ),
            ),
            Icon(Icons.arrow_forward_ios_rounded, color: Get.isDarkMode?black:white,)
          ],
        ));
  }
}
