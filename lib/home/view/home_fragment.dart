import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:wink/custom_widget/space.dart';
import 'package:wink/home/view/notification_screen.dart';
import 'package:wink/toast/flutter_toast.dart';

import 'package:wink/theme/theme.dart';
import 'package:wink/utils/widgets.dart';

import '../../controller/membership_controller.dart';
import '../home.dart';

class HomeFragment extends StatefulWidget {
  const HomeFragment({Key? key}) : super(key: key);

  @override
  State<HomeFragment> createState() => _HomeFragmentState();
}

class _HomeFragmentState extends State<HomeFragment> {

  final _sendWinkKey = GlobalKey<FormState>();
  // MembershipController membershipController = Get.put(MembershipController());
  //  final membershipController;
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
      bodyColor: colorScheme.onPrimaryContainer,
      displayColor: colorScheme.onPrimaryContainer,
    );
    print('home frag build');

    var membershipController = Get.put(MembershipController());
    return GetBuilder<MembershipController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: colorScheme.primaryContainer,
            elevation: 0.3,
            title: Text('WINK 보내기', style: textTheme.titleLarge,),
            actions: [
              // if (controller.userData?.isVerified?? false)
                Stack(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    padding: EdgeInsets.only(left: 10, top: 5, right: 15),
                    child: InkWell(
                      onTap: () {
                        Get.to(() => NotificationScreen());
                      },
                      child: Icon(Icons.notifications_none, size: 30, color: Get.isDarkMode ? white : black),
                    ),
                  ),
                  Positioned(
                    right: 9,
                    top: 0,
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
          body: controller.userData?.phoneNo != null
            ? controller.userData?.wink['winkTo'] == ''
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GetBuilder<MembershipController>(
                          builder: (controller) {
                            return RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(text: '내 아이디 : ', style: textTheme.titleLarge),
                                  TextSpan(text: controller.userData?.uid ?? '', style: textTheme.bodyLarge),
                                ]
                              ),
                            );
                          }
                        ),
                        Space(12),
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
                        Text('코인이 50개 필요합니다'),
                        Text('윙크를 보낼 전화번호를 입력하세요'),
                        Space(12),
                        GetBuilder<MembershipController>(
                          builder: (controller) {
                            return SizedBox(
                              child: Form(
                                key: _sendWinkKey,
                                child: TextFormField(
                                  controller: controller.winkToInput,
                                  keyboardType: TextInputType.phone,
                                  textInputAction: TextInputAction.send,
                                  inputFormatters: [LengthLimitingTextInputFormatter(11)],
                                  style: TextStyle(fontSize: 20),
                                  validator: (text) {
                                    if (text == null || text.isEmpty) {
                                      return '전화번호를 입력해주세요';
                                    }
                                    return null;
                                  },
                                  decoration: commonInputDecoration(hintText: "전화번호", prefixIcon: Icon(Icons.numbers_outlined)),
                                ),
                              ),
                            );
                          }
                        ),
                        Space(12),
                        GetBuilder<MembershipController>(
                          builder: (controller) {
                            return ElevatedButton(
                              onPressed: () async {
                                if (_sendWinkKey.currentState!.validate()) {
                                  showToast('wink to ${controller.winkToInput.value.text}', context);
                                  await controller.updateUser(controller.userData.uid, winkTo: controller.winkToInput.value.text.trim());
                                  controller.winkToInput.clear();
                                }

                              },
                              child: Text('wink 보내기'),
                            );
                          }
                        ),
                        Space(12),
                        ElevatedButton(
                          onPressed: (){
                            showToast('토스트 띄우기', context);
                          },
                          child: Text('토스트 버튼',),
                        ),
                      ],
                    ),
                  ),
                )
              : Center(
            child: GetBuilder<MembershipController>(
              builder: (controller) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('내가 wink 보낸 상대 : ${controller.userData?.wink['winkTo']}'),
                    Space(20),
                    Text('result'),
                    Text('null'),
                    ElevatedButton(
                      onPressed: () {
                        controller.updateUser(controller.userData.uid, winkTo: '');
                        showToast('reset wink', context);
                      },
                      child: Text('wink 초기화'),
                    ),
                  ],
                );
              }
            ),
          )
            : NotVerifiedScreen(),
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
          Space(12),
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
