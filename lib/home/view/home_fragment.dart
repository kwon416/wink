import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:wink/controller/fcm_controller.dart';
import 'package:wink/home/view/invite_screen.dart';
import 'package:wink/home/view/notification_screen.dart';
import 'package:wink/home/view/verification_screen.dart';
import 'package:wink/provider/sample_provider.dart';
import 'package:wink/utils/space.dart';
import 'package:wink/utils/flutter_toast.dart';

import 'package:wink/utils/widgets.dart';

import '../../controller/membership_controller.dart';
import '../../theme/theme.dart';
import '../../utils/constant.dart';

class HomeFragment extends StatefulWidget {
  const HomeFragment({super.key});

  @override
  State<HomeFragment> createState() => _HomeFragmentState();
}

class _HomeFragmentState extends State<HomeFragment> {
  final _sendWinkKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    print('home frag init ');
  }

  @override
  void didChangeDependencies() {
    // membershipController = Get.put(membershipController());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme.apply(
        //bodyColor: colorScheme.onPrimaryContainer,
        //displayColor: colorScheme.onPrimaryContainer,
        );
    //var controller = Get.put(MembershipController());
    return GetBuilder<MembershipController>(builder: (controller) {
      return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: colorScheme.primaryContainer,
            title: Text('Send WINK'.tr),
            leading: IconButton(
                onPressed: () =>
                    Get.changeTheme(Get.isDarkMode ? lightTheme : darkTheme),
                icon: Icon(Icons.change_circle_rounded)),
            actions: [
              // if (controller.userData?.isVerified?? false)
              InkWell(
                onTap: () {
                  Get.to(() => NotificationScreen());
                },
                child: Stack(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      padding: EdgeInsets.only(left: 10, top: 10, right: 15),
                      child: Icon(Icons.notifications_none),
                    ),
                    //배지 개수 표시
                    Positioned(
                      right: 9,
                      top: 4,
                      child: CircleAvatar(
                        radius: 10,
                        backgroundColor: Colors.red,
                        child: Text('3',
                            style: secondaryTextStyle(color: Colors.white)),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          backgroundColor: Colors.transparent,
          body: controller.userData?.wink['winkTo'] == ''
              ? Center(
                  child: Padding(
                    padding: EdgeInsets.all(appPadding),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text: 'ID : ', style: textTheme.titleLarge),
                            TextSpan(
                                text: controller.userData?.uid ?? '',
                                style: textTheme.bodyLarge),
                            // TextSpan(text: controller.userData?.uid ?? '', style: textTheme.bodyLarge),
                          ]),
                        ),
                        Space(buttonMargin),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                                height: 30,
                                decoration:
                                    BoxDecoration(shape: BoxShape.circle),
                                child: Image.asset('assets/icons/heart.png')),
                            Text(' : ${controller.userData?.coin}개')
                          ],
                        ),
                        Space(buttonMargin),
                        // Text('코인이 5개 필요합니다'),
                        // Space(buttonMargin),
                        Text('WINK를 보낼 ID를 입력하세요. \n 상대방은 익명으로 받게됩니다.'),
                        Space(buttonMargin),
                        SizedBox(
                          child: Form(
                            key: _sendWinkKey,
                            child: TextFormField(
                              controller: controller.winkToInput,
                              // keyboardType: TextInputType.phone,
                              textInputAction: TextInputAction.send,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(11)
                              ],
                              validator: (text) {
                                if (text == null || text.isEmpty) {
                                  return '전화번호를 입력해주세요';
                                }
                                return null;
                              },
                              decoration: commonInputDecoration(
                                  hintText: "ID",
                                  prefixIcon: Icon(Icons.numbers_outlined)),
                            ),
                          ),
                        ),
                        Space(buttonMargin),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              minimumSize: Size(double.infinity, 20)),
                          onPressed: () async {
                            if (_sendWinkKey.currentState!.validate()) {
                              // showToast('wink to ${controller.winkToInput.value.text}', context);
                              await controller.updateUser(
                                  controller.userData.uid,
                                  winkTo:
                                      controller.winkToInput.value.text.trim());
                              controller.winkToInput.clear();
                              showAppSnackBar('보내기', '내용');
                            }
                          },
                          child: Text('보내기'),
                        ),
                        // ElevatedButton(
                        //   onPressed: () async {
                        //     print('button clicked1');
                        //     SampleProvider.instance.postPushNotification();
                        //   },
                        //   child: Text('라우팅'),
                        // ),
                      ],
                    ),
                  ),
                )
              : Center(
                  child: Padding(
                    padding: EdgeInsets.all(appPadding),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                            '내가 wink 보낸 상대 : ${controller.userData?.wink['winkTo']}'),
                        Space(buttonMargin),
                        Text('result'),
                        Space(buttonMargin),
                        ElevatedButton(
                          onPressed: () {
                            controller.updateUser(controller.userData.uid,
                                winkTo: '');
                            showToast('reset wink', context);
                          },
                          child: Text('wink 초기화'),
                        ),
                        // ElevatedButton(
                        //   onPressed: () {
                        //     controller.generateAccessToken();
                        //     // controller.saveUser();
                        //     // controller.updateUser(controller.userData.uid, winkTo: '');
                        //     // showToast('reset wink', context);
                        //   },
                        //   child: Text('api test'),
                        // ),
                        Space(buttonMargin),
                        Text('더 많은 친구들을 초대해보세요!'),
                        Space(buttonMargin),
                        SDButton(
                            textContent: '친구 초대하기',
                            onPressed: () {
                              Get.to(() => InviteScreen());
                              // FlutterLocalNotificationsPlugin().show(0, 'title', 'body', NotificationDetails());
                            }),
                      ],
                    ),
                  ),
                ),
        ),
      );
    });
  }
}

class NotVerifiedScreen extends StatelessWidget {
  const NotVerifiedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('wink서비스를 이용하기 위해서 핸드폰 인증을 해주세요'),
          Space(buttonMargin),
          ElevatedButton(
            onPressed: () {
              showToast('인증 화면으로 이동', context);
              Get.to(() => VerificationScreen(), arguments: 'logIn');
            },
            child: Text('핸드폰 번호 인증하기'),
          ),
        ],
      ),
    );
  }
}
