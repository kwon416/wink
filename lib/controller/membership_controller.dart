import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import 'package:wink/repository/database_repository/database_repository.dart';
import 'package:wink/login/models/user.dart';

class MembershipController extends GetxController {
  static MembershipController get instance => Get.find();


  ///유저 데이터
  ///Map<Object?, dynamic>
  late final userData;

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
    userData  = await DatabaseRepository.instance.readUser(uid);
  }
}