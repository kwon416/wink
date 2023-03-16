import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../home/home.dart';
import '../../login/login.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;

  ///앱 시작시 호출, 파이어베이스유저 설정
  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  ///앱 시작 화면 설정
  _setInitialScreen(User? user) async {
    await Future.delayed(Duration(seconds: 2));
    print('Has user info? => ${user!=null}');
    user == null ? Get.offAll(() => const LoginPage()) : Get.offAll(() => HomePage());
  }

  Future<String?> createUserWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      firebaseUser.value != null ? Get.offAll(() => const HomePage()) : Get.to(() => const LoginPage());
    } on FirebaseAuthException catch(e) {
      print(e);
      return e.message;
    } catch (e) {
      print(e);
      return e.toString();
    }
    return null;
  }

  Future<String?> loginWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      print(e);
      return e.message;
    } catch (e) {
      print(e);
      return e.toString();
    }
    return null;
  }

  Future<void> logout() async => await _auth.signOut();
}