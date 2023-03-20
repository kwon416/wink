import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:wink/controller/signup_controller.dart';
// import 'package:wink/screens/otp_verification_screen.dart';
import 'package:wink/login/view/login_page.dart';
import 'package:wink/utils/constant.dart';
import 'package:wink/utils/widgets.dart';

import 'package:wink/custom_widget/space.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final controller = Get.put(SignUpController());
  final _signUpFormKey = GlobalKey<FormState>();

  final TextEditingController _passController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();

  bool agreeWithTeams = false;
  bool _securePassword = true;
  bool _secureConfirmPassword = true;

  double screenHeight = 0.0;
  double screenWidth = 0.0;

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
              child: Text('Ok'),
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

    return Stack(
      children: [

        Scaffold(
          backgroundColor: colorScheme.primaryContainer,
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Space(42),
                  Center(
                    child: Text(
                      "WINK",
                      style: TextStyle(fontSize: mainTitleTextSize, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Space(60),
                  Form(
                    key: _signUpFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextFormField(
                          controller: controller.userName,
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          style: TextStyle(fontSize: 16),
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return '이름을 입력해주세요';
                            }
                            return null;
                          },
                          decoration: commonInputDecoration(hintText: "이름",prefixIcon: Icon(Icons.person_outline_rounded)),
                        ),
                        Space(16),
                        TextFormField(
                          controller: controller.email,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          style: TextStyle(fontSize: 20),
                          validator: (text) {
                            Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                            RegExp regExp = RegExp(pattern.toString());
                            if (text == null || text.isEmpty) {
                              return '이메일을 입력해주세요';
                            }
                            if (!regExp.hasMatch(text)) {
                              return '잘못된 이메일 형식입니다';
                            }
                            return null;
                          },
                          decoration: commonInputDecoration(hintText: "이메일", prefixIcon: Icon(Icons.email_outlined)),
                        ),
                        Space(16),
                        TextFormField(
                          controller: controller.phoneNo,
                          keyboardType: TextInputType.phone,
                          textInputAction: TextInputAction.next,
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
                        Space(16),
                        TextFormField(
                          controller: controller.password,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: _securePassword,
                          style: TextStyle(fontSize: 20),
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return '패스워드를 입력해주세요';
                            }
                            if(text.length < 6) return '패스워드가 너무 짧습니다.';
                            return null;
                          },
                          decoration: commonInputDecoration(
                            hintText: "패스워드(6자리 이상)",
                            prefixIcon: Icon(Icons.lock_outline_rounded),
                            suffixIcon: Padding(
                              padding: EdgeInsets.only(right: 5.0),
                              child: IconButton(
                                icon: Icon(_securePassword ? Icons.visibility_off : Icons.visibility, size: 18),
                                onPressed: () {
                                  _securePassword = !_securePassword;
                                  setState(() {});
                                },
                              ),
                            ),
                          ),
                        ),
                        Space(16),
                        TextFormField(
                          controller: _confirmPassController,
                          textInputAction: TextInputAction.done,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: _secureConfirmPassword,
                          style: TextStyle(fontSize: 20),
                          validator: (text) {
                            if (text != controller.password.text) {
                              return '패스워드를 확인해주세요';
                            }
                            return null;
                          },
                          decoration: commonInputDecoration(
                            hintText: "패스워드 확인",
                            prefixIcon: Icon(Icons.lock_reset_outlined),
                            suffixIcon: Padding(
                              padding: EdgeInsets.only(right: 5.0),
                              child: IconButton(
                                icon: Icon(_secureConfirmPassword ? Icons.visibility_off : Icons.visibility, size: 18),
                                onPressed: () {
                                  _secureConfirmPassword = !_secureConfirmPassword;
                                  setState(() {});
                                },
                              ),
                            ),
                          ),
                        ),
                        Space(16),
                        Theme(
                          data: ThemeData(unselectedWidgetColor: colorScheme.primary),
                          child: CheckboxListTile(
                            contentPadding: EdgeInsets.all(0),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                            checkColor: colorScheme.onPrimary,
                            activeColor: colorScheme.primary,
                            title: Text("이용약관 동의", style: textTheme.bodySmall),
                            value: checkBoxValue,
                            dense: true,
                            onChanged: (newValue) {
                              setState(() {
                                checkBoxValue = newValue;
                              });
                            },
                            controlAffinity: ListTileControlAffinity.leading,
                          ),
                        ),
                        Space(16),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(16),
                              textStyle: TextStyle(fontSize: 20),
                              shape: StadiumBorder(),
                            ),
                            onPressed: () async {
                              if (_signUpFormKey.currentState!.validate()) {
                                if (checkBoxValue == true) {
                                  print('check success');

                                  controller.registerUser(
                                    controller.email.text.trim(),
                                    controller.password.text.trim(),
                                    controller.userName.text.trim(),
                                    controller.phoneNo.text.trim(),
                                  );

                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(builder: (context) => OTPVerificationScreen()),
                                  // );
                                } else {
                                  _showAlertDialog();
                                }
                              }
                            },
                            child: Text("회원가입",),
                          ),
                        ),
                        Space(20),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Have an account?", style: TextStyle(fontSize: 16)),
                              Space(4),
                              Text('로그인하기', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
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
    );
  }
}
