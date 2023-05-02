import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:wink/custom_widget/space.dart';
import 'package:wink/utils/widgets.dart';

import '../../utils/constant.dart';
import '../../utils/images.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  int itemCount = 0;

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme.apply(
      // bodyColor: colorScheme.onPrimaryContainer,
      // displayColor: colorScheme.onPrimaryContainer,
    );

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text("알림",),
      ),
      backgroundColor: colorScheme.primaryContainer,
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            itemCount = 3;
          });
        },
        child: itemCount != 0
        ?ListView.builder(
          // shrinkWrap: true,
          padding: EdgeInsets.symmetric(horizontal: appPadding),
          itemCount: itemCount,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: buttonMargin),
              child: ElevatedButton(
                onPressed: () {},
                child: Row(
                  children: [
                    Icon(Icons.ac_unit_sharp, size: 20),
                    Space(buttonMargin),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("알림 제목", style: TextStyle(fontWeight: FontWeight.bold)),
                        Space(buttonMargin),
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
        )
        :appEmptyWidget(splashLogo, '알림 내역이 없습니다.', ''),
      ),
    );
  }
}
