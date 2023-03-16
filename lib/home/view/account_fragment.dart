import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wink/controller/counter_controller.dart';
import 'package:wink/controller/login_controller.dart';
import 'package:wink/theme/theme.dart';

import '../../custom_widget/space.dart';

class AccountFragment extends StatelessWidget {
  const AccountFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CounterController c = Get.put(CounterController());
    final LoginController l = Get.put(LoginController());

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
            Text("email: ${l.getUserValue().email}"),
            Space(12),
            ElevatedButton(
              onPressed: () => Get.to(Other(), transition: Transition.topLevel),
              child: Text('새 페이지 get.to'),
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

