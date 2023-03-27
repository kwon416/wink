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

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme.apply(
      bodyColor: colorScheme.onPrimaryContainer,
      displayColor: colorScheme.onPrimaryContainer,
    );

    //핸드폰 인증 확인
    return GetBuilder<MembershipController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: colorScheme.primaryContainer,
            elevation: 0.3,
            title: Text('WINK 보내기', style: textTheme.titleLarge,),
            actions: [
              if (controller.isVerified)
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
              // Switch(
              //     value: context.watch<ThemeCubit>().state == ThemeMode.dark,
              //     onChanged: (newValue){
              //       context.read<ThemeCubit>().toggleTheme(newValue);
              //     }),
            ],
          ),
          backgroundColor: Colors.transparent,
          body: controller.isVerified
            ? controller.winkTo == ''
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
                                  TextSpan(text: '이메일 : ', style: textTheme.titleLarge),
                                  TextSpan(text: controller.userData?.email ?? '', style: textTheme.bodyLarge),
                                ]
                              ),
                            );
                          }
                        ),
                        Space(12),
                        Text('전화번호를 입력하세요'),
                        Space(12),
                        GetBuilder<MembershipController>(
                          builder: (controller) {
                            return SizedBox(
                              child: Form(
                                key: _sendWinkKey,
                                child: TextFormField(
                                  controller: controller.phoneNo,
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
                              onPressed: () {
                                if (_sendWinkKey.currentState!.validate()) {
                                  controller.updateWinkTo(controller.phoneNo.value.text);
                                }
                                showToast('wink to ${controller.winkTo}', context);
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
                    Text('내가 wink 보낸 상대 : ${controller.winkTo}'),
                    Space(20),
                    Text('result'),
                    Text('null'),
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
              Get.to(() => VerificationScreen());
            },
            child: Text('핸드폰 번호 인증하기'),
          ),
        ],
      ),
    );
  }
}
