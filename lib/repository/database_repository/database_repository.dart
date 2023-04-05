import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:wink/login/models/user_data.dart';

class DatabaseRepository extends GetxController {
  static DatabaseRepository get instance => Get.find();

  final DatabaseReference _ref = FirebaseDatabase.instance.ref("user/");

  Future<void> createUser(UserData user) async {
    await _ref.child(user.uid).set(user.toJson());
  }

  Future<bool> hasUser(String uid) async {
    final snapshot = await _ref.child(uid).get();
    if (snapshot.exists) {
      return Future.value(true);
    } else {
      return Future.value(false);
    }
  }
  
   Future<UserData> readUser(String uid) async {
     final snapshot = await _ref.child(uid).get();
     if (snapshot.exists) {
       return UserData.fromJson(snapshot.value as Map<Object?, dynamic>);
     } else {
       print('no data available');
       throw Exception('no data available');
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