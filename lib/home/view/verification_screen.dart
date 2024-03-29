import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:wink/controller/login_controller.dart';
import 'package:wink/controller/membership_controller.dart';
import 'package:wink/utils/space.dart';
import 'package:wink/utils/constant.dart';
import 'package:wink/utils/widgets.dart';

import '../../controller/signup_controller.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final _phoneNoInputKey = GlobalKey<FormState>();
  final _phonNoInputController = TextEditingController();

  var _sendComplete = false;
  bool isProcessing = false;

  final _verifyNoKey =GlobalKey<FormState>();
  final _verifyNoController = TextEditingController();

  final membershipController = Get.put(MembershipController());
  final signUpController = Get.put(SignUpController());
  final loginController = Get.put(LoginController());

  Timer? _timer;
  int _start = 60;
  bool _isActive = false;
  void startTimer() {
    setState(() {
      _isActive = true;
    });
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_start == 0) {
        setState(() {
          // _isActive = false;
          timer.cancel();
        });
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  void resetTimer() {
    setState(() {
      _isActive = false;
      _start = 60;
    });
    _timer?.cancel();
    startTimer();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      onVerticalDragEnd: (_) => FocusManager.instance.primaryFocus?.unfocus(),
      child: Stack(
        children: [
          Container(color: colorScheme.primaryContainer,),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(

              // title: SizedBox(child: Image.asset(splashLogo,fit: BoxFit.cover,height: AppBar().preferredSize.height )),
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
                  padding: EdgeInsets.all(appPadding),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('서비스 이용을 위해서 본인 확인을 진행합니다.'),
                      Text('휴대폰 번호를 입력해주세요.'),
                      Space(buttonMargin),
                      Form(
                        key: _phoneNoInputKey,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                            Space(buttonMargin),
                            ElevatedButton(
                              onPressed: isProcessing ? (){} : () async {
                                if (_phoneNoInputKey.currentState!.validate()) {
                                  setState(() {
                                    isProcessing = true;
                                  });
                                  print('입력 전화번호 : ${_phonNoInputController.value.text}');
                                  bool isMember = await loginController.checkPhoneNo(_phonNoInputController.value.text);

                                  if (Get.arguments == "logIn") {
                                    ///1. 로그인 인데 회원가입이 안되있는 경우
                                    if(!isMember) {
                                      Get.showSnackbar(GetSnackBar(message: '사용자 정보가 없습니다', duration: Duration(seconds: 2),));
                                      setState(() {
                                        isProcessing = false;
                                      });
                                      return;
                                    }
                                    print('로그인 인증번호 발송');
                                    loginController.verifyLoginUser(_phonNoInputController.value.text);
                                  } else if (Get.arguments == "signUp") {
                                    ///2. 회원가입인데 이미 가입되어 있는 경우
                                    if(isMember) {
                                      Get.showSnackbar(GetSnackBar(message: '이미 가입되어있는 사용자입니다', duration: Duration(seconds: 2),));
                                      setState(() {
                                        isProcessing = false;
                                      });
                                      return;
                                    }
                                    signUpController.verifyRegisterUser(_phonNoInputController.value.text);
                                  }

                                  Get.focusScope!.unfocus();
                                  setState(() {
                                    _sendComplete = true;
                                  });
                                  _isActive ? resetTimer() : startTimer();

                                  setState(() {
                                    isProcessing = false;
                                  });
                                }
                              },
                              child: Text(_sendComplete ? '     재발송     ' : '인증번호 받기'),
                            ),
                          ],
                        ),
                      ),
                      Space(40),
                      if (_sendComplete)
                      Column(
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Form(
                                key: _verifyNoKey,
                                child: SizedBox(
                                  width: Get.width*0.6,
                                  child: TextFormField(
                                    controller: _verifyNoController,
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
                                      if (text.length < 6) return '인증번호 6자리를 입력해주세요';
                                      return null;
                                    },
                                    decoration: commonInputDecoration(hintText: "", prefixIcon: Icon(Icons.check_outlined)),
                                  ),
                                ),
                              ),
                              Space(buttonMargin),
                              Text('$_start', style: boldTextStyle(color: redColor,decoration: TextDecoration.underline),),
                            ],
                          ),
                          Space(buttonMargin),
                          SizedBox(
                            width: Get.width,
                            child: ElevatedButton(
                              onPressed: isProcessing ? (){} : () async {
                                if (_verifyNoKey.currentState!.validate()) {
                                  setState(() {
                                    isProcessing = true;
                                  });
                                  // Create a PhoneAuthCredential with the code
                                  PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: membershipController.verificationId.toString(), smsCode: _verifyNoController.text);
                                  print(credential);

                                  if (Get.arguments == "signUp") {
                                    print('case : signUp');
                                    print("이름 : ${signUpController.userName.text}");
                                    print("성별 : ${signUpController.gender}");

                                    // auth 회원 가입 후 credential로 로그인
                                    await signUpController.loginUser(credential);
                                    //TODO: 회원가입 완료 팝업 띄우기
                                    // db에 회원 정보 생성
                                    signUpController.createUser(signUpController.userName.text, signUpController.gender.toString(), _phonNoInputController.text.trim());
                                  } else if (Get.arguments == "logIn"){
                                    print('case : logIn');
                                    await loginController.loginUser(credential);
                                  }
                                  setState(() {
                                    isProcessing = false;
                                  });
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
