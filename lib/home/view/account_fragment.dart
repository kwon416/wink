import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wink/controller/counter_controller.dart';
import 'package:wink/theme/theme.dart';

class AccountFragment extends StatelessWidget {
  const AccountFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CounterController c = Get.put(CounterController());

    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text('count : ${c.count}')),
        actions: [
          IconButton(onPressed: () => Get.changeTheme(Get.isDarkMode? lightTheme : darkTheme), icon: Icon(Icons.change_circle_rounded))
        ],
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => Get.to(Other()),
          child: Text('새 페이지 get.to'),
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

