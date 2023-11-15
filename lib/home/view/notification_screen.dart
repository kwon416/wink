import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:wink/utils/space.dart';
import 'package:wink/utils/widgets.dart';

import '../../utils/constant.dart';


class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  int itemCount = 0;

  Future<void> onRefresh() async {
    Future.delayed(Duration.zero);
    setState(() {
      itemCount = 30;
    });
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

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
      body: Scrollbar(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: appPadding),
          child: CustomRefreshIndicator(
            emptyMessageTitle: '알림 내역이 없습니다.',
            onRefresh: onRefresh,
            itemCount: itemCount,
            builder: (context, index) {
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
          ),
          // child: RefreshIndicator(
          //   onRefresh: () async {
          //     setState(() {
          //       itemCount = 3;
          //     });
          //   },
          //   child: itemCount != 0
          //   ?ListView.builder(
          //     // shrinkWrap: true,
          //     itemCount: itemCount,
          //     itemBuilder: (context, index) {
          //       return Padding(
          //         padding: EdgeInsets.symmetric(vertical: buttonMargin),
          //         child: ElevatedButton(
          //           onPressed: () {},
          //           child: Row(
          //             children: [
          //               Icon(Icons.ac_unit_sharp, size: 20),
          //               Space(buttonMargin),
          //               Column(
          //                 crossAxisAlignment: CrossAxisAlignment.start,
          //                 children: [
          //                   Text("알림 제목", style: TextStyle(fontWeight: FontWeight.bold)),
          //                   Space(buttonMargin),
          //                   Text(
          //                     "Thank you for order service using this app",
          //                     style: TextStyle(
          //                       fontSize: 12,
          //                       fontWeight: FontWeight.normal,
          //                       color: Get.isDarkMode ? Colors.white70 : Colors.grey.withOpacity(0.6),
          //                     ),
          //                   ),
          //                 ],
          //               )
          //             ],
          //           ),
          //         ),
          //       );
          //     },
          //   )
          //   :appEmptyWidget(splashLogo, '알림 내역이 없습니다.', ''),
          // ),
        ),
      ),
    );
  }
}
