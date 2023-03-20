import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:wink/repository/authentication_repository/authentication_repository.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  ///입력 폼 컨트롤러
  final email = TextEditingController();
  final password = TextEditingController();

  Future<void> loginUser(String email, String password) async {
    String? error = await AuthenticationRepository.instance.loginWithEmailAndPassword(email, password);
    if(error != null) {
      Get.showSnackbar(GetSnackBar(message: error.toString(), duration: Duration(seconds: 2),));
    }
  }

  getUser()  {
    return AuthenticationRepository.instance.firebaseUser;
  }

  Future<void> logOutUser() async {
    await AuthenticationRepository.instance.logout();
  }
}