import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wink/controller/login_controller.dart';
import 'package:wink/custom_widget/space.dart';
import 'package:wink/home/home.dart';
import 'package:wink/login/login.dart';
import 'package:wink/utils/images.dart';

import '../../utils/constant.dart';

class LoginForm extends StatefulWidget {
  LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final controller = Get.put(LoginController());
  final _formKey = GlobalKey<FormState>();
  final bool _securePassword = true;

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme.apply(
      bodyColor: colorScheme.onPrimaryContainer,
      displayColor: colorScheme.onPrimaryContainer,
    );

    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Space(60),
              Text("WINK", style: textTheme.displaySmall,),
              Space(buttonMargin),
              Text("Please Login to your account", style: textTheme.bodyLarge,),
              Space(buttonMargin),
              Image.asset(splashLogo, width: Get.height*0.3, fit: BoxFit.cover),
            ],
          ),
          Space(70),
          // TextFormField(
          //   controller: controller.email,
          //   keyboardType: TextInputType.emailAddress,
          //   textInputAction: TextInputAction.next,
          //   style: TextStyle(fontSize: 20),
          //   validator: (text) {
          //     if (text == null || text.isEmpty) {
          //       return '이메일을 입력해주세요';
          //     }
          //     return null;
          //   },
          //   decoration: commonInputDecoration(hintText: "이메일", prefixIcon: Icon(Icons.email_outlined)),
          // ),
          // const Padding(padding: EdgeInsets.all(12)),
          // TextFormField(
          //   controller: controller.password,
          //   textInputAction: TextInputAction.done,
          //   keyboardType: TextInputType.visiblePassword,
          //   obscureText: _securePassword,
          //   style: TextStyle(fontSize: 20),
          //   validator: (text) {
          //     if (text == null || text.isEmpty) {
          //       return '패스워드를 입력해주세요';
          //     }
          //     return null;
          //   },
          //   decoration: commonInputDecoration(
          //     hintText: "패스워드",
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
          // const Padding(padding: EdgeInsets.all(12)),

          ElevatedButton(
            //key: const Key('loginForm_continue_raisedButton'),
            onPressed: () {
              // print("email : ${controller.email.text}, password : ${controller.password.text}");
              // if (_formKey.currentState!.validate()) {
              //   controller.loginUser(controller.email.text, controller.password.text);
              //   return;
              // }
              // print('로그인 실패');
              Get.to(() => VerificationScreen(), arguments: 'logIn');
            },
            child: Text('기존 회원 로그인',),
          ),
          // const Padding(padding: EdgeInsets.all(12)),
          // ElevatedButton(
          //
          //   onPressed: () {
          //     controller.signInWithGoogle();
          //   },
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       GoogleLogoWidget(),
          //       Space(12),
          //       Text('구글 로그인',),
          //     ],
          //   ),
          // ),
          Space(appPadding),
          _LoginButton(),
          Space(appPadding),
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage()));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have account?", style: TextStyle(fontSize: 16)),
                Space(4),
                Text('회원가입', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// class _UsernameInput extends StatelessWidget {
//   const _UsernameInput({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<LoginBloc, LoginState>(
//       buildWhen: (previous, current) => previous.username != current.username,
//       builder: (context, state) {
//         return TextField(
//           key: const Key('loginForm_usernameInput_textField'),
//           onChanged: (username) => context.read<LoginBloc>().add(LoginUsernameChanged(username)),
//           decoration: InputDecoration(
//             labelText: '이메일',
//             errorText: state.username.invalid ? '유효하지 않은 이메일입니다' : null,
//           ),
//         );
//       },
//     );
//   }
// }
// class _PasswordInput extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<LoginBloc, LoginState>(
//       buildWhen: (previous, current) => previous.password != current.password,
//       builder: (context, state) {
//         return TextField(
//           key: const Key('loginForm_passwordInput_textField'),
//           onChanged: (password) =>
//               context.read<LoginBloc>().add(LoginPasswordChanged(password)),
//           obscureText: true,
//           decoration: InputDecoration(
//             labelText: '비밀번호',
//             errorText: state.password.invalid ? '유효하지 않은 비밀번호입니다' : null,
//           ),
//         );
//       },
//     );
//   }
// }

class _LoginButton extends StatelessWidget {
  final controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme.apply(
      bodyColor: colorScheme.onPrimaryContainer,
      displayColor: colorScheme.onPrimaryContainer,
    );

    return ElevatedButton(
            key: const Key('loginForm_continue_raisedButton'),
            onPressed: () {
                controller.loginEmailUser('admin@google.com', '123456');
              },
      child: Text('어드민 로그인',),
    );
  }
}