import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import 'package:wink/repository/database_repository/database_repository.dart';
import 'package:wink/login/models/user_data.dart';

class MembershipController extends GetxController {
  static MembershipController get instance => Get.find();


  ///유저 데이터
  ///Map<String, dynamic>
  late var userData;
  late String uid;

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