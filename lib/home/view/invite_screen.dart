import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:wink/utils/constant.dart';
import 'package:wink/utils/images.dart';

import '../../provider/dynamic_links.dart';
import '../../utils/space.dart';

import '../../utils/widgets.dart';

class InviteScreen extends StatefulWidget {
  const InviteScreen({super.key});

  @override
  State<InviteScreen> createState() => _InviteScreenState();
}

class _InviteScreenState extends State<InviteScreen> {
  // 변수 초기화
  int invitedCount = 0;
  bool isProcessing = false;

  // 초대장 링크를 복사하는 함수
  void copyLink() async {
    setState(() {
      isProcessing = true;
    });
    String inviteLink = await DynamicLinks().getShortLink('invite','id');
    Clipboard.setData(ClipboardData(text: inviteLink))
    .then((value) => showAppSnackBar('링크가 복사되었습니다.', inviteLink))
    .then((value) => print(inviteLink));
    await Future.delayed(Duration(seconds: buttonWaitDuration));
    setState(() {
      isProcessing = false;
    });
  }

  // 친구 초대 함수
  void inviteFriends(BuildContext context) async {
    final box = context.findRenderObject() as RenderBox?;
    setState(() {
      isProcessing = true;
    });
    String inviteLink = await DynamicLinks().getShortLink('invite','id');
    print(inviteLink);
    if(GetPlatform.isIOS){
      //pad에서 포지션 잡아줘야함

      await Share.share(inviteLink, subject: "Wink\n$inviteLink",
          sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
    }else{
      await Share.share(inviteLink, subject: "Wink\n$inviteLink");
    }
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      isProcessing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          // icon: FaIcon(FontAwesomeIcons.arrowLeft),
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
                  onPressed: isProcessing ? (){} : copyLink,
                  child: Text("링크 복사하기",),
                ),
                Space(buttonMargin),
                ElevatedButton(
                  onPressed: isProcessing ? (){} : (){inviteFriends(context);},
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

