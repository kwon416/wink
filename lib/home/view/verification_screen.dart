import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:quiver/async.dart';
import 'package:wink/controller/login_controller.dart';
import 'package:wink/controller/membership_controller.dart';
import 'package:wink/custom_widget/space.dart';
import 'package:wink/toast/flutter_toast.dart';
import 'package:wink/utils/images.dart';
import 'package:wink/utils/widgets.dart';

import '../../controller/signup_controller.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({Key? key}) : super(key: key);

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final _phoneNoInputKey = GlobalKey<FormState>();
  final _phonNoInputController = TextEditingController();

  var _sendComplete = false;
  // var _sendComplete = true;

  final _verifyNoKey =GlobalKey<FormState>();
  final _verifyNoController = TextEditingController();

  final membershipController = Get.put(MembershipController());
  final signUpController = Get.put(SignUpController());
  final loginController = Get.put(LoginController());

  final int _start = 60;
  int _current = 60;
  void startTimer() {
    CountdownTimer countDownTimer = CountdownTimer(
      Duration(seconds: _start),
      Duration(seconds: 1),
    );

    var sub = countDownTimer.listen(null);
    sub.onData((duration) {
      if(mounted) setState(() { _current = _start - duration.elapsed.inSeconds; });
    });

    sub.onDone(() {
      print("Done");
      sub.cancel();
    });
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme.apply(
      bodyColor: colorScheme.onPrimaryContainer,
      displayColor: colorScheme.onPrimaryContainer,
    );



    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      onVerticalDragEnd: (_) => FocusManager.instance.primaryFocus?.unfocus(),
      child: Stack(
        children: [
          Container(color: colorScheme.primaryContainer,),
          Scaffold(
            backgroundColor: Colors.transparent,
            // appBar: AppBar(
            //   backgroundColor: Colors.transparent,
            //   title: Text('휴대폰 인증',style: textTheme.titleLarge,),
            //   leading: IconButton(
            //     icon: Icon(Icons.arrow_back, color: colorScheme.onPrimaryContainer,),
            //     onPressed: () {
            //       Get.back();
            //     },
            //   ),
            // ),
            appBar: AppBar(
              centerTitle: true,
              elevation: 0,
              title: SizedBox(child: Image.asset(splashLogo,fit: BoxFit.cover,height: AppBar().preferredSize.height )),
              backgroundColor: Colors.transparent,
              iconTheme: IconThemeData(color: Get.isDarkMode ? Colors.white : Colors.black),
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Get.back();
                },
              ),
            ),
            body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('서비스 이용을 위해서 본인 확인을 진행합니다.'),
                      Text('휴대폰 번호를 입력해주세요.'),
                      Space(12),
                      Form(
                        key: _phoneNoInputKey,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: _phonNoInputController,
                                autofocus: true,
                                keyboardType: TextInputType.phone,
                                textInputAction: TextInputAction.done,
                                inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9]')),LengthLimitingTextInputFormatter(11)],
                                style: TextStyle(fontSize: 20),
                                // onEditingComplete: () => FocusManager.instance.primaryFocus?.unfocus(),
                                validator: (text) {
                                  RegExp regExp = RegExp(r'^010-?([0-9]{4})-?([0-9]{4})$');
                                  if (text == null || text.isEmpty) {
                                    return '전화번호를 입력해주세요';
                                  }
                                  if (!regExp.hasMatch(text)) {
                                    return '잘못된 전화번호 형식입니다';
                                  }
                                  return null;
                                },
                                decoration: commonInputDecoration(hintText: "전화번호", prefixIcon: Icon(Icons.numbers_outlined)),
                              ),
                            ),
                            Space(5),
                            ElevatedButton(
                              onPressed: () {
                                if (_phoneNoInputKey.currentState!.validate()) {
                                  print('입력 전화번호 : ${_phonNoInputController.value.text}');

                                  ///TODO
                                  ///1. 로그인 인데 회원가입이 안되있는 경우
                                  ///2. 회원가입인데 이미 가입되어 있는 경우
                                  // membershipController.verifyPhoneNumber(_phonNoInputController.value.text);

                                  if (Get.arguments == "logIn") {
                                    print('로그인 인증번호 발송');
                                    loginController.loginUser(_phonNoInputController.value.text);
                                  } else if (Get.arguments == "signUp") {
                                    signUpController.registerUser(_phonNoInputController.value.text);
                                  }

                                  Get.focusScope!.unfocus();
                                  setState(() {
                                    _sendComplete = true;
                                  });
                                  startTimer();
                                }
                              },
                              child: Text('인증번호 받기'),
                            ),
                          ],
                        ),
                      ),
                      Space(40),
                      if (_sendComplete)
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              showToast('message re-send', context);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("인증번호 안왔냐?", style: TextStyle(fontSize: 16)),
                                Space(4),
                                Text('재전송(미구현)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                              ],
                            ),
                          ),
                          Space(12),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Form(
                                key: _verifyNoKey,
                                child: SizedBox(
                                  width: Get.width*0.6,
                                  child: TextFormField(
                                    controller: _verifyNoController,
                                    autofocus: true,
                                    keyboardType: TextInputType.phone,
                                    textInputAction: TextInputAction.done,
                                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9]')),LengthLimitingTextInputFormatter(6)],
                                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                    onChanged: (value) {
                                      if (value.isEmpty) {
                                        FocusScope.of(context).previousFocus();
                                      }
                                    },
                                    // onEditingComplete: () => FocusManager.instance.primaryFocus?.unfocus(),
                                    validator: (text) {
                                      if (text == null || text.isEmpty) {
                                        return '인증번호를 입력해주세요';
                                      }
                                      if (text.length < 6) return '잘못된 인증번호입니다';
                                      return null;
                                    },
                                    decoration: commonInputDecoration(hintText: "", prefixIcon: Icon(Icons.check_outlined)),
                                  ),
                                ),
                              ),
                              Space(5),
                              Text('$_current sec')
                            ],
                          ),
                          Space(20),
                          SizedBox(
                            width: Get.width,
                            child: ElevatedButton(
                              onPressed: () async {
                                if (_verifyNoKey.currentState!.validate()) {


                                  // Create a PhoneAuthCredential with the code
                                  PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: membershipController.verificationId.toString(), smsCode: _verifyNoController.text);

                                  print(credential);

                                  // Sign the user in (or link) with the credential
                                  //await FirebaseAuth.instance.signInWithCredential(credential);

                                  //todo 회원 가입한 경우 유저 db저장 후 로그인
                                  if (Get.arguments == "signUp") {
                                    print('case : signUp');
                                    print(signUpController.userName.text);
                                    print(signUpController.gender);

                                    // auth 회원 가입 후 credential로 로그인
                                    await FirebaseAuth.instance.signInWithCredential(credential);
                                    // db에 회원 정보 생성
                                    membershipController.createUser(signUpController.userName.text, signUpController.gender.toString(), _phonNoInputController.text.trim());
                                  } else if (Get.arguments == "logIn"){
                                    print('case : logIn');

                                    await FirebaseAuth.instance.signInWithCredential(credential);
                                  }
                                }
                              },
                              child: Text('인증완료'),
                            ),
                          )
                        ],
                      ),

                    ],
                  ),
                ),
            ),
          ),
        ],
      ),
    );
  }
}
