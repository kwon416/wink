import 'dart:async';

import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wink/login/models/user_data.dart';

final navigatorKey = GlobalKey<NavigatorState>();


class DatabaseRepository extends GetxService {
  static DatabaseRepository get instance => Get.find();

  final DatabaseReference _ref = FirebaseDatabase.instance.ref("user/");

  Future<void> createUser(UserData user) async {
    await _ref.child(user.uid).set(user.toJson());
  }

  ///유저 중복 체크
  Future<bool> hasUser(String uid) async {
    final snapshot = await _ref.child(uid).get();
    if (snapshot.exists) {
      return Future.value(true);
    } else {
      return Future.value(false);
    }
  }
  ///가입되어 있는 전화번호인지 체크
  Future<bool> checkPhoneNo(String phoneNo) async {
    var value = await _ref.orderByChild('phoneNo').equalTo(phoneNo).once();
    if (value.snapshot.value != null) {
      return true;
    } else {
      return false;
    }

  }
  
   Future<UserData> readUser(String uid) async {
     try {
       final snapshot = await _ref.child(uid).get();
       if (snapshot.exists) {
         return UserData.fromJson(snapshot.value as Map<Object?, Object?>);
       } else {
         print('no data available');
         throw Exception('no data available');
       }
     } on FirebaseException catch (error) {
       print(error.code);
       switch (error.code) {
         case "permission-denied":
         ///todo firebase_database/permission-denied error 핸들링
         break;
         default:
           break;
       }
       throw Exception(Error);
     }
  }

  Future<void> updateUser(String uid, Map<String, dynamic> data) async {
    await _ref.child(uid).update(data);
  }

  Future<void> veryfyUser(String uid, Map<String, dynamic> data) async {
    await _ref.child(uid).update(data);
  }

  void deleteUser(String uid) async {
    await _ref.child(uid).remove();
  }
}