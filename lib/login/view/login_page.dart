import 'package:flutter/material.dart';
import 'package:wink/login/login.dart';
import 'package:wink/utils/constant.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  
  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const LoginPage());
  }

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  double screenHeight = 0.0;
  double screenWidth = 0.0;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      onVerticalDragEnd: (_) => FocusManager.instance.primaryFocus?.unfocus(),
      child: Stack(
        children: [
          Container(color: colorScheme.primaryContainer,),
          Scaffold(
            backgroundColor: Colors.transparent,
            // appBar: AppBar(
            //   backgroundColor: colorScheme.primaryContainer,
            //   title: Text('Login', style: textTheme.titleLarge,),
            // ),
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.all(appPadding),
              child: LoginForm(),
            ),
          ),
        ],
      ),
    );
  }
}
