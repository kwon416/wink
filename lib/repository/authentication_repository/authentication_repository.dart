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
    if (user?.email != null) {}
    user == null ? Get.offAll(() => const LoginPage()) : Get.offAll(() => HomePage());
  }
  ///auth 계정 생성
  Future<String?> createUserWithEmailAndPassword(String email, String password) async {
    String errorMessage;
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      firebaseUser.value != null ? Get.offAll(() => const HomePage()) : Get.to(() => const LoginPage());
    } on FirebaseAuthException catch (error) {
      print(error.code);
      switch (error.code) {
        case "invalid-email":
          errorMessage = "이메일 주소의 형식이 잘못되었습니다";
          break;
        case "email-already-in-use":
          errorMessage = "이미 존재하는 이메일 주소입니다";
          break;
        case "operation-not-allowed":
          errorMessage = "이메일 계정 생성이 비활성화되었습니다";
          break;
        case "weak-password":
          errorMessage = "패스워드가 너무 짧습니다";
          break;
        case "ERROR_TOO_MANY_REQUESTS":
          errorMessage = "Too many requests. Try again later.";
          break;
        case "ERROR_OPERATION_NOT_ALLOWED":
          errorMessage = "Signing in with Email and Password is not enabled.";
          break;
        default:
          errorMessage = "알 수 없는 오류가 발생했습니다.";

      }
      return errorMessage;
    } catch (e) {
      print(e);
      return e.toString();
    }
    return null;
  }
  ///auth 계정 로그인
  Future<String?> loginWithEmailAndPassword(String email, String password) async {
    String errorMessage;
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (error) {
      print(error.code);
      switch (error.code) {
        case "invalid-email":
          errorMessage = "이메일 주소의 형식이 잘못되었습니다";
          break;
        case "wrong-password":
          errorMessage = "패스워드가 잘못되었습니다";
          break;
        case "user-not-found":
          errorMessage = "존재하지 않는 이메일 주소입니다";
          break;
        case "user-disabled":
          errorMessage = "계정이 비활성화되었습니다";
          break;
        case "network-request-failed":
          errorMessage = "인터넷 연결을 확인해주세요";
          break;
        case "ERROR_OPERATION_NOT_ALLOWED":
          errorMessage = "Signing in with Email and Password is not enabled.";
          break;
        default:
          errorMessage = "알 수 없는 오류가 발생했습니다.";

      }
      return errorMessage;
    } catch (e) {
      print(e);
      return e.toString();
    }
    return null;
  }
  ///auth 계정 로그인 확인
  Future<bool> isUserLogin() async {
    var user =  _auth.currentUser;
    return user != null;
  }
  Future<String?> updateProfile({String? displayName, String? phoneNumber}) async {
    try {
      if (displayName != null) {
        await _auth.currentUser!.updateDisplayName(displayName);
      }
    } on FirebaseAuthException catch (error) {
      return error.message;
    } catch (e) {
      print(e);
      return e.toString();
    }
  }
  Future<void> logout() async => await _auth.signOut();
}