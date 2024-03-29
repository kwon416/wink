import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:wink/controller/signup_controller.dart';
// import 'package:wink/screens/otp_verification_screen.dart';
import 'package:wink/login/view/login_page.dart';
import 'package:wink/utils/flutter_toast.dart';
import 'package:wink/utils/colors.dart';
import 'package:wink/utils/constant.dart';
import 'package:wink/utils/images.dart';
import 'package:wink/utils/widgets.dart';

import 'package:wink/utils/space.dart';

import '../../home/view/verification_screen.dart';
import '../../theme/theme.dart';

const List<String> gender = ['남자', '여자', '미공개'];

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final controller = Get.put(SignUpController());
  final _signUpFormKey = GlobalKey<FormState>();

  final TextEditingController _passController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();

  bool agreeWithTeams = false;
  // bool _securePassword = true;
  // bool _secureConfirmPassword = true;

  double screenHeight = 0.0;
  double screenWidth = 0.0;

  // final List<bool> _selectedMenu = <bool>[true, false, false];
  final List<bool> _selectedMenu = List<bool>.filled(gender.length, false);

  bool? checkBoxValue = false;

  @override
  void dispose() {
    _passController.dispose();
    _confirmPassController.dispose();
    super.dispose();
  }

  Future<void> _showAlertDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Alert'),
          content: SingleChildScrollView(
            child: ListBody(children: const [Text('이용약관에 동의해주세요')]),
          ),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme.apply(
          bodyColor: colorScheme.onPrimaryContainer,
          displayColor: colorScheme.onPrimaryContainer,
        );

    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      onVerticalDragEnd: (_) => FocusManager.instance.primaryFocus?.unfocus(),
      child: Stack(
        children: [
          Scaffold(
            backgroundColor: colorScheme.primaryContainer,
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: EdgeInsets.all(appPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Space(AppBar().preferredSize.height),
                    Image.asset(
                      appIcon,
                      height: Get.statusBarHeight,
                    ),
                    Space(buttonMargin * 4),
                    Center(
                      child: Text(
                        "WINK 회원가입",
                        style: TextStyle(
                            fontSize: mainTitleTextSize,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    IconButton(
                        onPressed: () => Get.changeTheme(
                            Get.isDarkMode ? lightTheme : darkTheme),
                        icon: Icon(Icons.change_circle_rounded)),
                    Space(60),
                    Form(
                      key: _signUpFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('닉네임을 입력해주세요'),
                          Space(buttonMargin),
                          TextFormField(
                            controller: controller.userName,
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.done,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(15)
                            ],
                            style: TextStyle(fontSize: 20),
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return '닉네임을 입력해주세요';
                              }
                              return null;
                            },
                            decoration: commonInputDecoration(
                                hintText: "15자 이내로 입력해주세요",
                                prefixIcon: Icon(Icons.person_outline_rounded)),
                          ),
                          Space(buttonMargin),
                          Text('성별을 선택해주세요'),
                          Space(buttonMargin),
                          Center(
                            child: Container(
                              padding: EdgeInsets.zero,
                              decoration: BoxDecoration(
                                color: colorScheme.secondaryContainer,
                                border: Border.all(
                                    color: colorScheme.secondaryContainer),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(circularRadius)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0),
                                    spreadRadius: 1,
                                    blurRadius: 1,
                                    offset: Offset(
                                        0, 2), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: ToggleButtons(
                                onPressed: (index) {
                                  setState(() {
                                    for (int i = 0;
                                        i < _selectedMenu.length;
                                        i++) {
                                      _selectedMenu[i] = i == index;
                                    }
                                    if (index == 0) {
                                      controller.gender = gender[0].obs;
                                    } else if (index == 1) {
                                      controller.gender = gender[1].obs;
                                    } else {
                                      controller.gender = gender[2].obs;
                                    }
                                  });
                                },
                                borderColor: transparent,
                                selectedBorderColor: transparent,
                                selectedColor: colorScheme.onPrimary,
                                fillColor: transparent,
                                color: colorScheme.onPrimaryContainer,
                                isSelected: _selectedMenu,
                                children: [
                                  for (int i = 0; i < gender.length; i++)
                                    toggleContainer(gender[i], colorScheme,
                                        _selectedMenu[i]),
                                ],
                              ),
                            ),
                          ),
                          // Space(16),
                          // TextFormField(
                          //   controller: controller.email,
                          //   keyboardType: TextInputType.emailAddress,
                          //   textInputAction: TextInputAction.next,
                          //   style: TextStyle(fontSize: 20),
                          //   validator: (text) {
                          //     Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                          //     RegExp regExp = RegExp(pattern.toString());
                          //     if (text == null || text.isEmpty) {
                          //       return '이메일을 입력해주세요';
                          //     }
                          //     if (!regExp.hasMatch(text)) {
                          //       return '잘못된 이메일 형식입니다';
                          //     }
                          //     return null;
                          //   },
                          //   decoration: commonInputDecoration(hintText: "이메일", prefixIcon: Icon(Icons.email_outlined)),
                          // ),
                          // Space(16),
                          // TextFormField(
                          //   controller: controller.phoneNo,
                          //   keyboardType: TextInputType.phone,
                          //   textInputAction: TextInputAction.next,
                          //   inputFormatters: [LengthLimitingTextInputFormatter(11)],
                          //   style: TextStyle(fontSize: 20),
                          //   validator: (text) {
                          //     if (text == null || text.isEmpty) {
                          //       return '전화번호를 입력해주세요';
                          //     }
                          //     return null;
                          //   },
                          //   decoration: commonInputDecoration(hintText: "전화번호", prefixIcon: Icon(Icons.numbers_outlined)),
                          // ),
                          // Space(16),
                          // TextFormField(
                          //   controller: controller.password,
                          //   textInputAction: TextInputAction.next,
                          //   keyboardType: TextInputType.visiblePassword,
                          //   obscureText: _securePassword,
                          //   style: TextStyle(fontSize: 20),
                          //   validator: (text) {
                          //     if (text == null || text.isEmpty) {
                          //       return '패스워드를 입력해주세요';
                          //     }
                          //     if(text.length < 6) return '패스워드가 너무 짧습니다.';
                          //     return null;
                          //   },
                          //   decoration: commonInputDecoration(
                          //     hintText: "패스워드(6자리 이상)",
                          //     prefixIcon: Icon(Icons.lock_outline_rounded),
                          //     suffixIcon: Padding(
                          //       padding: EdgeInsets.only(right: 5.0),
                          //       child: IconButton(
                          //         icon: Icon(_securePassword ? Icons.visibility_off : Icons.visibility, size: 18),
                          //         onPressed: () {
                          //           _securePassword = !_securePassword;
                          //           setState(() {});
                          //         },
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          // Space(16),
                          // TextFormField(
                          //   controller: _confirmPassController,
                          //   textInputAction: TextInputAction.done,
                          //   autovalidateMode: AutovalidateMode.onUserInteraction,
                          //   keyboardType: TextInputType.visiblePassword,
                          //   obscureText: _secureConfirmPassword,
                          //   style: TextStyle(fontSize: 20),
                          //   validator: (text) {
                          //     if (text != controller.password.text) {
                          //       return '패스워드를 확인해주세요';
                          //     }
                          //     return null;
                          //   },
                          //   decoration: commonInputDecoration(
                          //     hintText: "패스워드 확인",
                          //     prefixIcon: Icon(Icons.lock_reset_outlined),
                          //     suffixIcon: Padding(
                          //       padding: EdgeInsets.only(right: 5.0),
                          //       child: IconButton(
                          //         icon: Icon(_secureConfirmPassword ? Icons.visibility_off : Icons.visibility, size: 18),
                          //         onPressed: () {
                          //           _secureConfirmPassword = !_secureConfirmPassword;
                          //           setState(() {});
                          //         },
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          Space(buttonMargin),
                          CheckboxListTile(
                            contentPadding: EdgeInsets.all(0),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(borderRadius)),
                            checkColor: colorScheme.onPrimary,
                            activeColor: colorScheme.primary,
                            title: Text("이용약관 동의", style: textTheme.bodyLarge),
                            value: checkBoxValue,
                            dense: true,
                            onChanged: (newValue) {
                              setState(() {
                                checkBoxValue = newValue;
                              });
                            },
                            controlAffinity: ListTileControlAffinity.leading,
                          ),
                          Space(buttonMargin),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: ElevatedButton(
                              // style: ElevatedButton.styleFrom(
                              //   padding: EdgeInsets.all(16),
                              //   textStyle: TextStyle(fontSize: 16),
                              //   shape: StadiumBorder(),
                              // ),
                              onPressed: () async {
                                if (_signUpFormKey.currentState!.validate()) {
                                  if (controller.gender.value != '') {
                                    print(controller.gender);
                                    if (checkBoxValue == true) {
                                      print('signUp check success');
                                      Get.to(() => VerificationScreen(),
                                          arguments: 'signUp');
                                      // controller.registerUser(
                                      //   controller.email.text.trim(),
                                      //   controller.password.text.trim(),
                                      //   controller.userName.text.trim(),
                                      //   //폰 번호 입력받지 않고 공백처리
                                      //   // controller.phoneNo.text.trim(),
                                      //   ''
                                      // );

                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(builder: (context) => OTPVerificationScreen()),
                                      // );
                                    } else {
                                      _showAlertDialog();
                                    }
                                  } else {
                                    showToast('성별을 선택해주세요', context);
                                  }
                                }
                              },
                              child: Text(
                                "전화번호 인증하기",
                              ),
                            ),
                          ),
                          Space(buttonMargin * 2),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("이미 계정이 있으신가요?"),
                                Space(4),
                                Text('로그인',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                          )
                        ],
                      ),
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
