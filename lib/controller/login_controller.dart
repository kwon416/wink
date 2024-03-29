import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:wink/repository/authentication_repository/authentication_repository.dart';
import 'package:wink/repository/database_repository/database_repository.dart';

import 'membership_controller.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  static final membershipController = Get.put(MembershipController());

  ///입력 폼 컨트롤러
  final email = TextEditingController();
  final password = TextEditingController();

  ///이메일 패스워드 로그인 ->> 현재는 어드민 로그인
  Future<void> loginEmailUser(String email, String password) async {
    String? error = await AuthenticationRepository.instance.loginWithEmailAndPassword(email, password);
    if(error != null) {
      Get.showSnackbar(GetSnackBar(message: error.toString(), duration: Duration(seconds: 2),));
    }
  }
  ///회원인지 체크
  Future<bool> checkPhoneNo(String phoneNo) async {
    bool isMember = await DatabaseRepository.instance.checkPhoneNo(phoneNo);
    print('check phoneNo --> isMember? : $isMember');
    return isMember;
  }

  ///전화번호 인증
  Future<bool> verifyLoginUser(String phoneNumber) async {
    String? error = await AuthenticationRepository.instance.verifyPhoneNumber(phoneNumber);
    if(error != null) {
      Get.showSnackbar(GetSnackBar(message: error.toString(), duration: Duration(seconds: 2),));
      return Future.value(false);
    }
    return Future.value(true);
  }
  ///전화번호 인증번호 로그인
  Future<void> loginUser(PhoneAuthCredential credential) async {
    String? error = await AuthenticationRepository.instance.signInWithCredential(credential);
    if(error != null) {
      Get.showSnackbar(GetSnackBar(message: error.toString(), duration: Duration(seconds: 2),));
    }
  }

  ///미사용
  signInWithGoogle() async {
    var result = await AuthenticationRepository.instance.signInWithGoogle();
    print(result);
    ///firebase realtime database 저장
    Rx<User?> rxUser = AuthenticationRepository.instance.firebaseUser;
    if (! await DatabaseRepository.instance.hasUser(rxUser.value!.uid) && rxUser.value != null) membershipController.createEmailUser(rxUser,"email","password","userName","phoneNumber");
  }

  getUser()  {
    return AuthenticationRepository.instance.firebaseUser;
  }

  Future<void> logOutUser() async {
    await AuthenticationRepository.instance.logout();
  }

  Future<void> deleteUser() async {
    String uid = membershipController.uid;
    //db 삭제
    await DatabaseRepository.instance.deleteUser(uid);
    // auth 정보 삭제
    await AuthenticationRepository.instance.deleteUser();
  }
}