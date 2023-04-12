import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wink/controller/membership_controller.dart';


import 'package:wink/repository/authentication_repository/authentication_repository.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  static final membershipController = Get.put(MembershipController());

  ///회원가입 입력 폼
  final email = TextEditingController();
  final password = TextEditingController();
  final userName = TextEditingController();
  final phoneNo = TextEditingController();
  RxString gender = ''.obs;

  ///이메일 회원가입 (미사용)
  Future<void> registerEmailUser(String email, String password, String userName, String phoneNumber) async {
    ///firebase auth 계정 생성
    String? error = await AuthenticationRepository.instance.createUserWithEmailAndPassword(email, password);
    if(error != null) {
      Get.showSnackbar(GetSnackBar(message: error.toString(), duration: Duration(seconds: 2),));
    }
    ///firebase realtime database 저장
    Rx<User?> rxUser = AuthenticationRepository.instance.firebaseUser;
    if (rxUser.value != null) membershipController.createEmailUser(rxUser,email,password,userName,phoneNumber);
  }
  ///전화번호 회원가입
  Future<void> registerUser(String phoneNumber) async {
    //번호 인증
    String? error = await AuthenticationRepository.instance.verifyPhoneNumber(phoneNumber);
    if(error != null) {
      print('에러 있나요');
      print(error.toString());
      Get.showSnackbar(GetSnackBar(message: error.toString(), duration: Duration(seconds: 2),));
    }
  }

  ///유저 정보 업데이트 - 미사용
  void updateProfile({String? displayName, String? phoneNumber}) {
    Future<String?> error = AuthenticationRepository.instance.updateProfile(displayName: displayName, phoneNumber: phoneNumber);
    if(error != null) {
      Get.showSnackbar(GetSnackBar(message: error.toString(),));
    }
  }
}