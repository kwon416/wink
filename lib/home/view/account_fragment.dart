import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:wink/controller/login_controller.dart';
import 'package:wink/controller/membership_controller.dart';
import 'package:wink/home/view/editprofile_screen.dart';
import 'package:wink/home/view/invite_screen.dart';
import 'package:wink/home/view/setting_screen.dart';
import 'package:wink/utils/colors.dart';
import 'package:wink/utils/images.dart';

import '../../utils/space.dart';
import '../../utils/constant.dart';
import '../../utils/widgets.dart';

class AccountFragment extends StatelessWidget {
  const AccountFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme.apply(
      // bodyColor: colorScheme.onPrimaryContainer,
      // displayColor: colorScheme.onPrimaryContainer,
    );

    // final LoginController l = Get.put(LoginController());
    return GetBuilder<MembershipController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            // iconTheme: IconThemeData(color: Get.isDarkMode ? Colors.white : Colors.black),
            backgroundColor: colorScheme.primaryContainer,
            title: Text('Profile'.tr),
            actions: [
              GestureDetector(
                onTap: () {
                  purchaseBottomSheet(context);
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(icHeart, height: iconSizeLarge),
                    Text(' ${controller.userData?.coin}  ', style: boldTextStyle(color: colorScheme.onPrimaryContainer)),
                  ],
                ),
              ),
            ],
          ),
          body: Center(
            child: Stack(
              children: [
                Container(width: Get.width, color: Colors.black12,),
                Container(
                  alignment: Alignment.topRight,
                  margin: EdgeInsets.only(top: 40, right: 16),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.close, color: white, size: 30),
                  ),
                ),

                SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: EdgeInsets.all(appPadding),
                        decoration: boxDecorationWithShadow(
                          borderRadius: BorderRadius.circular(borderRadius),
                          backgroundColor: transparent,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            CircleAvatar(backgroundImage: AssetImage(splashLogo), radius: 70,backgroundColor: colorScheme.primary),
                            Space(buttonMargin),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(controller.userData?.userName, style: boldTextStyle(color: colorScheme.onPrimaryContainer)),
                                Space(buttonMargin),
                                Text(controller.userData?.phoneNo, style: primaryTextStyle(color: colorScheme.onPrimaryContainer)),
                                Space(buttonMargin),
                                Text(controller.userData?.uid, style: secondaryTextStyle(color: colorScheme.onPrimaryContainer)),
                              ],
                            ).expand()
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(borderRadius), topRight: Radius.circular(borderRadius)),
                          color: colorScheme.primaryContainer,
                        ),
                        padding: EdgeInsets.symmetric(vertical: appPadding, horizontal: appPadding),
                        width: Get.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            settIngContainer(
                              icon: Icons.edit,
                              title: '프로필 수정',
                              boxColor: colorScheme.primary,
                              textColor: colorScheme.onPrimary,
                              onTap: () {
                                Get.to(() => (EditProfileScreen()));
                                // SHEditProfileScreen().launch(
                                //   context,
                                //   pageRouteAnimation: PageRouteAnimation.SlideBottomTop,
                                // );
                              },
                            ),
                            settIngContainer(
                              icon: Icons.person,
                              title: '친구 초대',
                              boxColor: colorScheme.primary,
                              textColor: colorScheme.onPrimary,
                              onTap: () {
                                // controller.getCurrentUser(l.getUser().value.uid);
                                Get.to(() => InviteScreen());
                              },
                            ),
                            settIngContainer(
                              icon: Icons.settings,
                              title: 'Settings'.tr,
                              boxColor: colorScheme.primary,
                              textColor: colorScheme.onPrimary,
                              onTap: () {

                                Get.to(() => SettingScreen());

                              },
                            ),
                            Space(buttonMargin*2),
                            settIngContainer(
                              icon: Icons.chat,
                              title: 'Terms of use',
                              boxColor: colorScheme.primary,
                              textColor: colorScheme.onPrimary,
                              onTap: () {
                                // showToast('Terms of use', context);
                                // showAppDialog('123', 'middleText');

                              }
                            ),
                            settIngContainer(
                              icon: Icons.send,
                              title: 'Contact',
                              boxColor: colorScheme.primary,
                              textColor: colorScheme.onPrimary,
                              onTap: () {
                                Get.to(() => Other());
                              }
                            ),
                            Space(buttonMargin*2),
                            settIngContainer(
                              icon: Icons.logout,
                              title: '로그아웃',
                              boxColor: colorScheme.primary,
                              textColor: Colors.deepOrange,
                              onTap: () {
                                  LoginController().logOutUser();
                              },
                            ),
                            Row(children: [Text('v', style: primaryTextStyle(color: colorScheme.onPrimaryContainer),), VersionInfoWidget(textStyle: primaryTextStyle(color: colorScheme.onPrimaryContainer)),],).paddingLeft(16),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      }
    );
  }
}

class Other extends GetView<MembershipController> {
  Other({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme.apply(
      bodyColor: colorScheme.onPrimaryContainer,
      displayColor: colorScheme.onPrimaryContainer,
    );
    LoginController l = Get.put(LoginController());

    BannerAd bannerAd = BannerAd(
        size: AdSize.banner,
        adUnitId: GetPlatform.isIOS ? iosTestBannerAdId : androidTestBannerAdId,
        listener: BannerAdListener(
          onAdFailedToLoad: (Ad ad, LoadAdError error) {},
          onAdLoaded: (_) {},
        ),
        request: AdRequest(),
    )..load();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.primaryContainer,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),),
      backgroundColor: colorScheme.primaryContainer,
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: appPadding),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  // height: (Get.width-(appPadding*2)) * 0.15625,
                  width: 320,
                  height: 50,
                  child: AdWidget(ad: bannerAd)
                ),
                Text('auth user instance', style: TextStyle(fontWeight: FontWeight.bold),),
                Text(l.getUser().toString()),
                Space(20),
                Text('User Data From Realtime DB From firebase', style: TextStyle(fontWeight: FontWeight.bold),),
                Text('get userName : ${controller.userData?.userName}'),
                Text('get uid : ${controller.userData?.uid}'),
                Text('get fcmToken : ${controller.userData?.fcmToken}'),
                Text('get phoneNo : ${controller.userData?.phoneNo}'),
                Text('get gender : ${controller.userData?.gender}'),
                Text('get coin : ${controller.userData?.coin}'),
                Text('get winkData : ${controller.userData?.wink}'),

                Space(buttonMargin),
                SDButton(
                  textContent: '새로고침',
                  onPressed: () {
                    controller.getCurrentUser(controller.uid);
                  },
                ),
                Space(buttonMargin),
                SDButton(
                  textContent: '강제종료',
                  onPressed: () {
                    exit(0);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

