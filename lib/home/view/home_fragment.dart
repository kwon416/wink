import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:wink/custom_widget/space.dart';
import 'package:wink/toast/flutter_toast.dart';


import 'package:wink/utils/widgets.dart';

import '../../controller/membership_controller.dart';
import '../../theme/theme.dart';
import '../../utils/constant.dart';
import '../home.dart';

class HomeFragment extends StatefulWidget {
  const HomeFragment({Key? key}) : super(key: key);

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
    print('home frag build');


    //var controller = Get.put(MembershipController());
    return GetBuilder<MembershipController>(
      builder: (controller) {
        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: colorScheme.primaryContainer,

              title: Text('WINK 보내기'),
              leading: IconButton(onPressed: () => Get.changeTheme(Get.isDarkMode? lightTheme : darkTheme), icon: Icon(Icons.change_circle_rounded)),
              actions: [
                // if (controller.userData?.isVerified?? false)
                Stack(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      padding: EdgeInsets.only(left: 10, top: 10, right: 15),
                      child: InkWell(
                        onTap: () {
                          Get.to(() => NotificationScreen());
                        },
                        child: Icon(Icons.notifications_none),
                      ),
                    ),
                    //배지 개수 표시
                    Positioned(
                      right: 9,
                      top: 4,
                      child: CircleAvatar(
                        radius: 10,
                        backgroundColor: Colors.red,
                        child: Text('3', style: secondaryTextStyle(color: Colors.white)),
                      ),
                    )
                  ],
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
                      text: TextSpan(
                          children: [
                            TextSpan(text: '내 아이디 : ', style: textTheme.titleLarge),
                            TextSpan(text: controller.userData?.uid ?? '', style: textTheme.bodyLarge),
                            // TextSpan(text: controller.userData?.uid ?? '', style: textTheme.bodyLarge),
                          ]
                      ),
                    ),
                    Space(buttonMargin),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                            height: 30,
                            decoration: BoxDecoration(shape: BoxShape.circle),
                            child: Image.asset('assets/icons/heart.png')
                        ),
                        Text(' : ${controller.userData?.coin}개')
                      ],
                    ),
                    Space(buttonMargin),
                    Text('코인이 50개 필요합니다'),
                    Space(buttonMargin),
                    Text('윙크를 보낼 전화번호를 입력하세요'),
                    Space(buttonMargin),
                    SizedBox(
                      child: Form(
                        key: _sendWinkKey,
                        child: TextFormField(
                          controller: controller.winkToInput,
                          keyboardType: TextInputType.phone,
                          textInputAction: TextInputAction.send,
                          inputFormatters: [LengthLimitingTextInputFormatter(11)],
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return '전화번호를 입력해주세요';
                            }
                            return null;
                          },
                          decoration: commonInputDecoration(hintText: "전화번호", prefixIcon: Icon(Icons.numbers_outlined)),
                        ),
                      ),
                    ),
                    Space(buttonMargin),
                    ElevatedButton(
                      onPressed: () async {
                        if (_sendWinkKey.currentState!.validate()) {
                          showToast('wink to ${controller.winkToInput.value.text}', context);
                          await controller.updateUser(controller.userData.uid, winkTo: controller.winkToInput.value.text.trim());
                          controller.winkToInput.clear();
                        }

                      },
                      child: Text('보내기'),
                    ),
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
                    Text('내가 wink 보낸 상대 : ${controller.userData?.wink['winkTo']}'),
                    Space(buttonMargin),
                    Text('result'),
                    Space(buttonMargin),
                    ElevatedButton(
                      onPressed: () {
                        controller.updateUser(controller.userData.uid, winkTo: '');
                        showToast('reset wink', context);
                      },
                      child: Text('wink 초기화'),
                    ),
                    Space(buttonMargin),
                    SDButton(
                        textContent: 'status',
                        onPressed: () {
                          toast('tost');
                          // FlutterLocalNotificationsPlugin().show(0, 'title', 'body', NotificationDetails());
                        }
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}

class NotVerifiedScreen extends StatelessWidget {
  const NotVerifiedScreen({Key? key}) : super(key: key);

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
