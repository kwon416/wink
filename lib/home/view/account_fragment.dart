import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:wink/controller/login_controller.dart';
import 'package:wink/controller/membership_controller.dart';
import 'package:wink/home/view/editProfile_screen.dart';
import 'package:wink/home/view/setting_screen.dart';
import 'package:wink/theme/theme.dart';
import 'package:wink/utils/colors.dart';
import 'package:wink/utils/images.dart';

import '../../custom_widget/space.dart';
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

    final LoginController l = Get.put(LoginController());
    return GetBuilder<MembershipController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            // iconTheme: IconThemeData(color: Get.isDarkMode ? Colors.white : Colors.black),
            backgroundColor: colorScheme.primaryContainer,
            title: Text('프로필',),
            actions: [
              IconButton(
                  onPressed: () => Get.to(() => SettingScreen()),
                  icon: Icon(Icons.settings)
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
                    onPressed: () {
                    },
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
                            10.width,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                5.height,
                                Text(controller.userData?.userName, style: boldTextStyle(color: colorScheme.onPrimaryContainer)),
                                5.height,
                                Text(controller.userData?.phoneNo, style: primaryTextStyle(color: colorScheme.onPrimaryContainer)),
                                5.height,
                                Text(controller.userData?.uid, style: secondaryTextStyle(color: colorScheme.secondary)),
                              ],
                            ).expand()
                          ],
                        ),
                      ),

                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(borderRadius), topRight: Radius.circular(borderRadius)),
                          color: colorScheme.primary,
                        ),
                        padding: EdgeInsets.symmetric(vertical: appPadding, horizontal: appPadding),
                        width: Get.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            settIngContainer(
                              icon: Icons.edit,
                              title: '프로필 수정',
                              boxColor: colorScheme.primaryContainer,
                              textColor: colorScheme.onPrimaryContainer,
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
                              title: 'Member',
                              boxColor: colorScheme.primaryContainer,
                              textColor: colorScheme.onPrimaryContainer,
                              onTap: () {
                                controller.getCurrentUser(l.getUser().value.uid);
                                // SHMemberScreen().launch(context, pageRouteAnimation: PageRouteAnimation.SlideBottomTop);
                              },
                            ),
                            settIngContainer(
                              icon: Icons.settings,
                              title: '설정',
                              boxColor: colorScheme.primaryContainer,
                              textColor: colorScheme.onPrimaryContainer,
                              onTap: () {
                                // Get.to(() => Other());
                                Get.to(() => SettingScreen());

                              },
                            ),
                            16.height,
                            settIngContainer(icon: Icons.chat, title: 'Terms of use', boxColor: colorScheme.primaryContainer,
                                textColor: colorScheme.onPrimaryContainer),
                            settIngContainer(icon: Icons.send, title: 'Contact', boxColor: colorScheme.primaryContainer,
                                textColor: colorScheme.onPrimaryContainer),
                            16.height,
                            settIngContainer(
                              icon: Icons.logout,
                              title: '로그아웃',
                              boxColor: colorScheme.primaryContainer,
                              textColor: Colors.deepOrange,
                              onTap: () {
                                  LoginController().logOutUser();
                              },
                            ),
                            Row(children: [Text('v', style: primaryTextStyle(color: colorScheme.primaryContainer),), VersionInfoWidget(textStyle: primaryTextStyle(color: colorScheme.primaryContainer)),],).paddingLeft(16),
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
    LoginController l = Get.find();
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
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: appPadding),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('auth user instance', style: boldTextStyle(),),
                        Text(l.getUser().toString()),
                        Space(20),
                        Text('User Data From Realtime DB From firebase', style: boldTextStyle(),),
                        Text('get userName : ${controller.userData?.userName}'),
                        Text('get uid : ${controller.userData?.uid}'),
                        Text('get fcmToken : ${controller.userData?.fcmToken}'),
                        Text('get phoneNo : ${controller.userData?.phoneNo}'),
                        Text('get gender : ${controller.userData?.gender}'),
                        Text('get coin : ${controller.userData?.coin}'),
                        Text('get winkData : ${controller.userData?.wink}'),

                Space(12),
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

