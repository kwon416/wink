import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wink/utils/space.dart';
import 'package:wink/home/home.dart';
// import 'package:home_hub/main.dart';
// import 'package:home_hub/screens/dashboard_screen.dart';
import 'package:wink/utils/colors.dart';

import '../../utils/constant.dart';

// import '../login.dart';

class OTPVerificationScreen extends StatefulWidget {
  const OTPVerificationScreen({Key? key}) : super(key: key);

  @override
  State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  final _otpFormKey = GlobalKey<FormState>();

  late double screenHeight;
  late double screenWidth;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme.apply(
      bodyColor: colorScheme.onPrimaryContainer,
      displayColor: colorScheme.onPrimaryContainer,
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color:blackColor),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(appPadding),
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SizedBox(
              height: screenHeight * 0.35,
              width: screenWidth,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.mail_outline, size: 50, color: colorScheme.onPrimaryContainer,),
                  Text(
                    "SMS 본인인증",
                    style: textTheme.displaySmall,
                  ),
                  Space(16),
                  Text("인증번호가 발송되었습니다.", style: textTheme.labelLarge,),
                ],
              ),
            ),
            Form(
              key: _otpFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 60,
                    width: 150,
                    child: Center(
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                        inputFormatters: [LengthLimitingTextInputFormatter(6), FilteringTextInputFormatter.digitsOnly],
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: textFieldColor,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(borderRadius),
                            borderSide: BorderSide.none,
                          ),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(borderRadius)),
                        ),
                        onChanged: (value) {
                          if (value.isEmpty) {
                            FocusScope.of(context).previousFocus();
                          }
                        },
                      ),
                    ),
                  ),
                  Space(40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Didn't receive OTP?", style: TextStyle(fontSize: 16, color: subText)),
                      Space(4),
                      GestureDetector(
                        onTap: () {
                          //
                        },
                        child: Text(
                          "Resend OTP",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: orangeColor),
                        ),
                      ),
                    ],
                  ),
                  Space(40),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(buttonPadding),
                            textStyle: TextStyle(fontSize: 25),
                            shape: StadiumBorder(),
                          ),
                          onPressed: () async {
                            if (_otpFormKey.currentState!.validate()) {

                            }
                            print(_otpFormKey.toString());
                            Navigator.push(context, MaterialPageRoute(builder: (_) => HomePage()));

                            //context.read<LoginBloc>().add(const LoginSubmitted());
                          },
                          child: Text(
                            "Submit",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
