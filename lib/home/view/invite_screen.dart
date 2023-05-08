import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:wink/utils/constant.dart';
import 'package:wink/utils/images.dart';

import '../../utils/space.dart';
import '../../utils/colors.dart';

class InviteScreen extends StatefulWidget {
  const InviteScreen({Key? key}) : super(key: key);

  @override
  State<InviteScreen> createState() => _InviteScreenState();
}

class _InviteScreenState extends State<InviteScreen> {
  // 변수 초기화
  int invitedCount = 0;

  // 초대장 링크를 복사하는 함수
  void copyLink() {
    // TODO: 초대장 링크 복사 기능 구현
  }

  // 친구 초대 함수
  void inviteFriends() {
    // TODO: 친구 초대 기능 구현
  }

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
          // icon: Icon(Icons.arrow_back),
          icon: FaIcon(FontAwesomeIcons.arrowLeft),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text("친구 초대"),
      ),
      backgroundColor: colorScheme.primaryContainer,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(appPadding),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "친구를 초대해보세요!",
                  style: TextStyle(
                    fontSize: textSizeLarge,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Space(buttonMargin),
                Image.asset(
                  splashLogo,
                  width: Get.width/2,
                ),
                Space(buttonMargin),
                Text("초대한 사람 수: $invitedCount",),
                Space(buttonMargin),
                ElevatedButton(
                  onPressed: copyLink,
                  child: Text("링크 복사하기",),
                ),
                Space(buttonMargin),
                ElevatedButton(
                  onPressed: inviteFriends,
                  child: Text("친구 초대하기",),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

