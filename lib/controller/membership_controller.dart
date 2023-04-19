import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wink/provider/sample_provider.dart';


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

  ///임시 winkTo 등록
  final winkToInput =TextEditingController();

  void createEmailUser(Rx<User?> rxUser, String email, String password, String userName, String phoneNumber) {
    // final user = UserData(
    //   gender: rxUser.value?.email ?? email,
    //   uid: rxUser.value!.uid,
    //   password: password,
    //   phoneNo: rxUser.value?.phoneNumber ?? '',
    //   userName: rxUser.value?.displayName ?? userName,
    //   isVerified: false,
    // );
    // DatabaseRepository.instance.createUser(user);
  }

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
  ///현재 uid 값으로 db에서 유저데이터 가져오기
  Future<bool> getCurrentUser(String uid) async {
    this.uid = uid;
    print('run getCurrentUser uid: $uid');
    userData  =  await DatabaseRepository.instance.readUser(uid);
    // Future.delayed(Duration.zero);
    update();
    print('End run getCurrentUser');
    return Future.value(true);
  }
  ///fcm Token 업데이트
  Future<void> updateFcmToken(String uid, String fcmToken) async {
    print("start FCM Token update");
    final Map<String, dynamic> data = {"fcmToken": fcmToken};
    await DatabaseRepository.instance.updateUser(uid, data);
    await getCurrentUser(uid);
  }

  ///유저 정보 업데이트(성별, 이름, 윙크)
  Future<void> updateUser(String uid, {String? gender, String? userName, String? winkTo}) async {
    final Map<String, dynamic> data = {};
    if (gender != null) data.addAll({"gender" : gender});
    if (userName != null) data.addAll({"userName" : userName});
    if (winkTo != null) data.addAll({"wink/winkTo" : winkTo});

    await DatabaseRepository.instance.updateUser(uid, data);
    await getCurrentUser(uid);
  }

  ///유저 전화번호 인증 완료 db 저장 미사용
  // Future<void> verifyUser(String uid, String phoneNumber) async {
  //   final Map<String, dynamic> data = {};
  //   data.addAll({"isVerified" : true});
  //   data.addAll({"phoneNo" : phoneNumber});
  //
  //   await DatabaseRepository.instance.veryfyUser(uid, data);
  //   await getCurrentUser(uid);
  // }

  SampleProvider sampleProvider = SampleProvider();
  void fcmPushNoti() {
    sampleProvider.postPushNotification();
  }

  void deleteUser(String uid) {
    DatabaseRepository.instance.deleteUser(uid);
  }
}