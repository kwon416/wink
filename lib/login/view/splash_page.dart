import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class SplashPage extends StatelessWidget {
  // ignore: use_super_parameters
  const SplashPage({Key? key}) : super(key: key);

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const SplashPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: GetPlatform.isAndroid
        ? CircularProgressIndicator()
        : CupertinoActivityIndicator(radius: 15),
      ),
    );
  }
}
