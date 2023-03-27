import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:wink/repository/database_repository/database_repository.dart';
import 'package:wink/login/models/user_data.dart';

class MembershipController extends GetxController {
  static MembershipController get instance => Get.find();


  ///유저 데이터
  ///Map<String, dynamic>
  var userData;
  late String uid;

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
        phoneNo: rxUser.value?.phoneNumber ?? phoneNumber,
        userName: rxUser.value?.displayName ?? userName,
    );
    DatabaseRepository.instance.createUser(user);
  }

  Future<void> getCurrentUser(String uid) async {
    this.uid = uid;
    print(uid);
    userData  = await DatabaseRepository.instance.readUser(uid);
    Future.delayed(Duration.zero);
    update();
  }

  void updateUser(
    String uid,
  {
    String? phoneNo,
    String? userName
  }) {
    final Map<String, dynamic> data = {};
    if (phoneNo != null) data.addAll({"phoneNo" : phoneNo});
    if (userName != null) data.addAll({"userName" : userName});

    DatabaseRepository.instance.updateUser(uid, data);
  }

  void deleteUser(String uid) {
    DatabaseRepository.instance.deleteUser(uid);
  }
}