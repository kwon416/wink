import 'package:flutter/material.dart';
import 'package:flutter_material_symbols/flutter_material_symbols.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:wink/theme/theme_data.dart';
import 'package:wink/utils/constant.dart';
import 'package:wink/utils/widgets.dart';

import '../../utils/images.dart';
import '../home.dart';
// import 'package:prokit_flutter/fullApps/flixv2/model/setting_model.dart';
// import 'package:prokit_flutter/fullApps/flixv2/utils/common_widgets.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  State<SettingScreen> createState() => SettingScreenState();
}

class SettingScreenState extends State<SettingScreen> {
  List<String> title = ['General'.tr, 'Cache'.tr, 'Others'.tr];
  List<String> generalSettings = ['Language settings'.tr, 'Stream Quality', 'Notification settings'.tr, 'Dark mode'.tr];

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
  List<String> cacheList = ['Enable cache'.tr, 'Delete cache'.tr];
  List<IconData> leadingcatchIconList = [Icons.square_rounded, Icons.cleaning_services_rounded];
  List<String> otherSetings = ['Privacy Policy'.tr, 'Terms of use'.tr, 'Contact us'.tr];
  List<IconData> otherSetingsLeadingIcon = [
    Icons.privacy_tip,
    // Icons.notifications,
    Icons.chat,
    Icons.send,
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
        title: Text("Settings".tr),
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
    );
  }

  generalSettingsComponent(int index) {
    List trailingIcons = [
      Text(
        'Language'.tr,
        style: secondaryTextStyle(color: Get.isDarkMode?black:white),
      ),
      Text(
        'Full HD',
        style: secondaryTextStyle(color: Get.isDarkMode?black:white),
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
      onTap: () {
        switch (index) {
          case 0:
            Get.to(() => LanguageSettingScreen());
        }

      },
      child: Container(
        height: iconSizeSmall + 2*buttonPadding,
        width: MediaQuery.of(context).size.width - appPadding*2,
        padding: EdgeInsets.only(left: buttonPadding, right: buttonPadding),
        // padding: EdgeInsets.all(buttonPadding),
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
    return GestureDetector(
      onTap: () async {
        if (index == 0){
        }
        if (index == 1) {
          showAppSnackBar("캐시 데이터가 삭제됨", "123");
          // Get.snackbar("캐시 데이터가 삭제됨", "123",snackPosition: SnackPosition.BOTTOM);
        }
      },
      child: Container(
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
                  ? SizedBox(height: iconSizeSmall,
                    child: customAdaptiveSwitch(
                    value: enableCache,
                    onChanged: (newvalue) {
                      enableCache = !enableCache;
                      setState(() {});
                    }),
                  )
                  : Offstage(),
            ],
          )),
    );
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

class LanguageSettingScreen extends StatefulWidget {
  const LanguageSettingScreen({Key? key}) : super(key: key);

  @override
  State<LanguageSettingScreen> createState() => _LanguageSettingScreenState();
}

class _LanguageSettingScreenState extends State<LanguageSettingScreen> {

  @override
  Widget build(BuildContext context) {
    List<IconData> languageLeadingIcon = [Icons.language, Icons.language, Icons.language,];
    List<String> languageList = ['Korean'.tr, 'English'.tr, 'Japanese'.tr];
    List<Locale> localeList = [Locale('ko_KR'), Locale('en_US'), Locale('ja_JP')];
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.primaryContainer,
        title: Text("Language settings".tr),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Get.updateLocale(Get.deviceLocale?? const Locale('ko_KR'));
              Get.offAll(() => HomePage());
            },
            child: Padding(
              padding: EdgeInsets.only(right: buttonPadding),
              child: Center(child: Text('Reset'.tr, style: primaryTextStyle(color: colorScheme.primary),)),
            ),
          ),
        ],
      ),
      backgroundColor: colorScheme.primaryContainer,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: appPadding),
        child: Center(
          child: ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) {
                print(Get.locale);
                return GestureDetector(
                  onTap: () {
                    Get.updateLocale(localeList[index]);
                    Get.offAll(() => HomePage());
                  },
                  child: Container(
                      margin: EdgeInsets.symmetric(vertical: buttonMargin),
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
                            languageLeadingIcon[index],
                            color: Get.isDarkMode?black:white,
                          ),
                          SizedBox(width: buttonPadding),
                          Expanded(
                            child: Text(
                              languageList[index],
                              // otherSetings[index],
                              style: primaryTextStyle(color: colorScheme.onPrimary),
                            ),
                          ),
                          if (Get.locale.toString() == localeList[index].toString())
                          Icon(Icons.check, color: Get.isDarkMode?black:white,)
                        ],
                      )),
                );
              },
          ),
        ),
      ),
    );
  }
}
