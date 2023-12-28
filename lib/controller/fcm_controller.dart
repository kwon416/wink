
import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class FcmController extends GetxController {
  static FcmController get instance => Get.find();

  final fcm = FirebaseMessaging.instance;
  late var token;
  late StreamSubscription<String> _subscription;
  @override
  void onInit() async {
    super.onInit();

    // fcm 초기화
    fcm.setAutoInitEnabled(true);
    // fcm 토큰 발급
    token = await fcm.getToken();
    debugPrint("$token");
    // 토큰 리프레시 리스너 등록
    _subscription = fcm.onTokenRefresh.listen((newToken) {
      // TODO: If necessary send token to application server.

      // Note: This callback is fired at each app startup and whenever a new
      // token is generated.
    },
    onDone: () {
      _subscription.cancel();
    },
    onError: (e) {

    });

  }

  ///파이어베이스 알림 권한 요청?
  void initializeNotification() async {
    NotificationSettings settings = await fcm.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    print('User granted fcm notification permission: ${settings.authorizationStatus}');
  }
}