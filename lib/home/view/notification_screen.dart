import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:wink/custom_widget/space.dart';
import 'package:wink/utils/colors.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
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
        ),
        title: Text(
          "알림",
          textAlign: TextAlign.center,
          style: TextStyle(color: Get.isDarkMode ? Colors.white : Colors.black),
        ),
      ),
      backgroundColor: colorScheme.primaryContainer,
      body: ListView.builder(
        padding: EdgeInsets.all(8),
        itemCount: 20,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: ElevatedButton(
              onPressed: () {},
              child: Row(
                children: [
                  Icon(Icons.ac_unit_sharp, size: 20),
                  Space(16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("알림 제목", style: TextStyle(fontWeight: FontWeight.bold)),
                      Space(8),
                      Text(
                        "Thank you for order service using this app",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          color: Get.isDarkMode ? Colors.white70 : Colors.grey.withOpacity(0.6),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
