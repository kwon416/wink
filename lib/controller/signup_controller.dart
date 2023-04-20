import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wink/controller/membership_controller.dart';
import 'package:wink/login/models/user_data.dart';


import 'package:wink/repository/authentication_repository/authentication_repository.dart';
import 'package:wink/repository/database_repository/database_repository.dart';

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
  ///전화번호 인증
  Future<void> verifyRegisterUser(String phoneNumber) async {
    //번호 인증
    String? error = await AuthenticationRepository.instance.verifyPhoneNumber(phoneNumber);
    if(error != null) {
      Get.showSnackbar(GetSnackBar(message: error.toString(), duration: Duration(seconds: 2),));
    }
  }
  ///전화번호 인증번호 로그인
  Future<void> loginUser(PhoneAuthCredential credential) async {
    String? error = await AuthenticationRepository.instance.signInWithCredential(credential);
    if(error != null) {
      Get.showSnackbar(GetSnackBar(message: error.toString(), duration: Duration(seconds: 2),));
    }
  }

  ///신규 회원 디비 저장
  void createUser(String userName, String gender, String phoneNumber) {
    Rx<User?> rxUser = AuthenticationRepository.instance.firebaseUser;
    final user = UserData(
        userName: rxUser.value?.displayName ?? userName,
        gender: gender,
        phoneNo: phoneNumber,
        uid: rxUser.value!.uid,
        coin: 0,
        fcmToken: '',
        wink: {"winkTo": '', "winkFrom": ""}
    );
    DatabaseRepository.instance.createUser(user);
  }

  ///유저 정보 업데이트 - 미사용
  void updateProfile({String? displayName, String? phoneNumber}) {
    Future<String?> error = AuthenticationRepository.instance.updateProfile(displayName: displayName, phoneNumber: phoneNumber);
    if(error != null) {
      Get.showSnackbar(GetSnackBar(message: error.toString(),));
    }
  }
}