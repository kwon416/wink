import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:wink/repository/database_repository/database_repository.dart';
import 'package:wink/repository/authentication_repository/authentication_repository.dart';
import 'package:wink/login/models/user_data.dart';

class MembershipController extends GetxController {
  static MembershipController get instance => Get.find();


  ///유저 데이터
  ///Map<String, dynamic>
  var userData;
  late String uid;

  ///임시 verificationId
  String verificationId = '';
  setVerificationId(String s) {
    verificationId = s;
    update();
  }

  ///임시 인증 변수
  bool isVerified = false;
  void verify() {
    isVerified = true;
    update();
  }
  ///임시 winkTo 등록
  final phoneNo =TextEditingController();
  String winkTo = '';
  void updateWinkTo(String value) {
    winkTo = value;
    update();
  }


  void createUser(Rx<User?> rxUser, String email, String password, String userName, String phoneNumber) {
    final user = UserData(
      email: rxUser.value?.email ?? email,
      uid: rxUser.value!.uid,
      password: password,
      phoneNo: rxUser.value?.phoneNumber ?? '',
      userName: rxUser.value?.displayName ?? userName,
      isVerified: false,
    );
    DatabaseRepository.instance.createUser(user);
  }

  Future<void> getCurrentUser(String uid) async {
    this.uid = uid;
    print('run getCurrentUser');
    userData  = await DatabaseRepository.instance.readUser(uid);
    Future.delayed(Duration.zero);
    update();
    print('End run getCurrentUser');

  }

  Future<void> updateUser(String uid, {String? phoneNo, String? userName}) async {
    final Map<String, dynamic> data = {};
    if (phoneNo != null) data.addAll({"phoneNo" : phoneNo});
    if (userName != null) data.addAll({"userName" : userName});

    await DatabaseRepository.instance.updateUser(uid, data);
    await getCurrentUser(uid);
  }

  Future<void> verifyPhoneNumber(String phoneNumber) async {
    String? error = await AuthenticationRepository.instance.verifyPhoneNumber(phoneNumber);
    if(error != null) {
      print('에러 있나요');
      print(error.toString());
      Get.showSnackbar(GetSnackBar(message: error.toString(), duration: Duration(seconds: 2),));
    }
  }

  ///유저 전화번호 인증 완료 db 저장
  Future<void> verifyUser(String uid, String phoneNumber) async {
    final Map<String, dynamic> data = {};
    data.addAll({"isVerified" : true});
    data.addAll({"phoneNo" : phoneNumber});

    await DatabaseRepository.instance.veryfyUser(uid, data);
    await getCurrentUser(uid);
  }

  void deleteUser(String uid) {
    DatabaseRepository.instance.deleteUser(uid);
  }
}