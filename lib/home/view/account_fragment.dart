import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wink/controller/login_controller.dart';
import 'package:wink/controller/membership_controller.dart';
import 'package:wink/theme/theme.dart';

import '../../custom_widget/space.dart';
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
    //final MembershipController controller = Get.put(MembershipController());
    return GetBuilder<MembershipController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            // iconTheme: IconThemeData(color: Get.isDarkMode ? Colors.white : Colors.black),
            backgroundColor: colorScheme.primaryContainer,
            title: Text('계정 관리',),
            actions: [
              IconButton(onPressed: () => Get.changeTheme(Get.isDarkMode? lightTheme : darkTheme), icon: Icon(Icons.change_circle_rounded))
            ],
          ),
          body: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    children: [
                      Text('auth user instance'),
                      Text(l.getUser().toString()),
                      Space(20),
                      Text('User Data From Realtime DB From firebase'),
                      Text('get userName : ${controller.userData?.userName}'),
                      Text('get uid : ${controller.userData?.uid}'),
                      Text('get fcmToken : ${controller.userData?.fcmToken}'),
                      Text('get phoneNo : ${controller.userData?.phoneNo}'),
                      Text('get gender : ${controller.userData?.gender}'),
                      Text('get coin : ${controller.userData?.coin}'),
                      Text('get winkData : ${controller.userData?.wink}'),
                    ],
                  ),
                  Space(12),
                  ElevatedButton(
                    onPressed: () => Get.to(() => Other()),
                    child: Text('새 페이지 get.to'),
                  ),
                  Space(12),
                  ElevatedButton(onPressed: () => LoginController().logOutUser(), child: Text('파이어베이스 로그아웃')),

                  Space(12), ElevatedButton(
                    onPressed: () async {
                      controller.fcmPushNoti();
                    },
                    child: Text('fcmPushNoti'),
                  ),
                  Space(12),
                  ElevatedButton(
                    onPressed: () async {
                      controller.getCurrentUser(l.getUser().value.uid);
                    },
                    child: Text('getCurrentUser'),
                  ),
                  Space(12),
                  ElevatedButton(
                    onPressed: () async {
                      exit(0);
                    },
                    child: Text('강제 종료'),
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            child: Icon(Icons.add)
          ),
        );
      }
    );
  }
}

class Other extends StatelessWidget {
  Other({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme.apply(
      bodyColor: colorScheme.onPrimaryContainer,
      displayColor: colorScheme.onPrimaryContainer,
    );

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: colorScheme.primaryContainer,
        iconTheme: IconThemeData(color: Get.isDarkMode ? Colors.white : Colors.black),
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
            padding: EdgeInsets.only(left: 25, right: 25),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('새 페이지'),
                Space(12),
                SDButton(
                  textContent: 'nb util button 유틸 버튼',
                  onPressed: () {


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

