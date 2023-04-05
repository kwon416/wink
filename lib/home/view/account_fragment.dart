import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wink/controller/counter_controller.dart';
import 'package:wink/controller/login_controller.dart';
import 'package:wink/controller/membership_controller.dart';
import 'package:wink/theme/theme.dart';

import '../../custom_widget/space.dart';

class AccountFragment extends StatelessWidget {
  const AccountFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CounterController c = Get.put(CounterController());
    final LoginController l = Get.put(LoginController());
    final MembershipController m = Get.put(MembershipController());


    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text('count : ${c.count}')),
        actions: [
          IconButton(onPressed: () => Get.changeTheme(Get.isDarkMode? lightTheme : darkTheme), icon: Icon(Icons.change_circle_rounded))
        ],
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GetBuilder<MembershipController>(
              builder: (controller) {
                return Column(
                  children: [
                    Text('auth user instance'),
                    Text(l.getUser().toString()),
                    Space(20),
                    Text('User Data From Realtime DB From firebase'),
                    Text('get userName : ${controller.userData?.userName}'),
                    Text('get uid : ${controller.userData?.uid}'),
                    Text('get phoneNo : ${controller.userData?.phoneNo}'),
                    Text('get password : ${controller.userData?.password}'),
                    Text('get email : ${controller.userData?.email}'),
                    Text('get isVerifired : ${controller.userData?.isVerified}'),
                  ],
                );
              }
            ),
            Space(12),
            ElevatedButton(
              onPressed: () => Get.to(Other()),
              child: Text('새 페이지 get.to'),
            ),
            Space(12),
            ElevatedButton(
              onPressed: () async {
                m.updateUser(m.userData.uid, userName: '권보궁');
              },
              child: Text('username update test'),
            ),
            Space(12),
            ElevatedButton(
              onPressed: () async {
                // m.deleteUser('IsAIyINVOBe0ZtG1DE6W1siUTwP2');
              },
              child: Text('delete test'),
            ),
            Space(12),
            ElevatedButton(onPressed: () => LoginController().logOutUser(), child: Text('파이어베이스 로그아웃'))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: c.increment,
        child: Icon(Icons.add)
      ),
    );
  }
}

class Other extends StatelessWidget {
  Other({Key? key}) : super(key: key);

  final CounterController c = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('${c.count}'),),);
  }
}

