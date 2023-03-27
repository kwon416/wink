import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wink/controller/membership_controller.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme.apply(
      bodyColor: colorScheme.onPrimaryContainer,
      displayColor: colorScheme.onPrimaryContainer,
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.primaryContainer,
        title: Text('번호 인증하기',style: textTheme.titleLarge,),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colorScheme.onPrimaryContainer,),
          onPressed: () {
            Get.back();
          },

        ),
      ),
      body: Center(
          child: GetBuilder<MembershipController>(
            builder: (controller) {
              return ElevatedButton(
                onPressed: () async {
                  controller.verify();
                  Get.back(result: true);
                },
                child: Text('인증완료'),
              );
            }
          ),
      ),
    );
  }
}
