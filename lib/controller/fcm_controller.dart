
import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wink/controller/membership_controller.dart';

import '../main.dart';

class FcmController extends GetxController {
  static FcmController get instance => Get.find();
  late MembershipController m;

  final fcm = FirebaseMessaging.instance;
  late var token;
  late StreamSubscription<String> _tokenRefreshSubscription;
  late StreamSubscription<RemoteMessage> _foregroundPushSubscription;
  @override
  void onInit() async {
    super.onInit();
    // fcm 초기화
    fcm.setAutoInitEnabled(true);
  }

  ///FCM 초기화 runApp 이후 호출
  void initializeNotification() async {
    debugPrint('Fcm initializeNotification');
    m = Get.find();
    //알림 권한 요청
    NotificationSettings settings = await fcm.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    // 토큰 발급
    print('User granted fcm notification permission: ${settings.authorizationStatus}');
    fcm.getToken().then((token) {
      debugPrint("get FCM token : ${token ?? 'token NULL!'}");
      if(token != null) {
        // FCM 토큰을 서버에 저장 👈👈👈👈👈👈👈👈👈👈👈
        // if(token != null) m.updateFcmToken(l.getUser().value.uid, token);
        this.token = token;
        m.updateFcmToken(m.uid, token);
      }
      // client.post(Uri.parse(Constants.API + 'booster/v1/fcm-token'), body: jsonEncode({ 'fcmToken': "$token" }));
    });

    // 토큰 리프레시 리스너 등록
    _tokenRefreshSubscription = fcm.onTokenRefresh.listen((newToken) {
      debugPrint("on refresh FCM token : $newToken");
      // TODO: If necessary send token to application server.
      token = newToken;
      m.updateFcmToken(m.uid, newToken);
      // Note: This callback is fired at each app startup and whenever a new
      // token is generated.
    },
        onDone: () {
          _tokenRefreshSubscription.cancel();
        },
        onError: (e) {

        });
    // 포어그라운드 푸시 리스너 등록
    await _firebaseMessagingForegroundHandler();
  }

  /// 포어 그라운드 푸시 알림 처리
  Future<void> _firebaseMessagingForegroundHandler() async {
    RemoteMessage? initialMessage = await fcm.getInitialMessage();
    //
    if (initialMessage != null) {
      debugPrint('initial message exist: ${initialMessage.toMap()}');
      _handleMessage(initialMessage);
    }

    ///파이어 베이스 포어 그라운드 푸시 알림 처리
    _foregroundPushSubscription = FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message: ${message.toMap()}');
      // 안드로이드 포어에서는 FCM으로 못열기 때문에 메세지를 로컬 노티로 열어줌
      if (Platform.isAndroid) showFlutterNotification(message);
    },
    onDone: () {
      _foregroundPushSubscription.cancel();
    },
    onError: (e) {});

    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  /// 포어 그라운드 푸시 클릭 핸들링
  void _handleMessage(RemoteMessage message) {
    debugPrint("in handleMessage : ${message.toMap()}");
    if (message.data['status'] != null && message.data['status'].toString().startsWith('/')) {
      Get.toNamed('${message.data['status']}');
    }
  }

  ///Custom notifications for Android foreground
  void showFlutterNotification(RemoteMessage message) {
    print("run showFlutterNotification");
    RemoteNotification? notification = message.notification;
    Map<String, dynamic>? data = message.data;
    // AndroidNotification? android = message.notification?.android;
    if (true) {
      flutterLocalNotificationsPlugin.show(
        notification?.hashCode ?? data.hashCode,
        notification?.title ?? data['title'],
        notification?.body ?? data['body'],
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker',
            // icon: '@mipmap/ic_launcher',
            // actions: <AndroidNotificationAction>[
            //   AndroidNotificationAction(
            //       'id_1', data["key_1"] ?? '',
            //   ),
            //   AndroidNotificationAction('id_2', data["key_2"] ?? ''),
            //   AndroidNotificationAction('id_3', 'Action 3'),
            // ],
            // TODO add a proper drawable resource to android, for now using
            //      one that already exists in example app.
          ),
          iOS: DarwinNotificationDetails(
            badgeNumber: 0,
            //subtitle: 'the subtitle',
            //sound: 'slow_spring_board.aiff',
          ),
        ),
        payload: data['status'],
        // payload: message?.data as String,
      );
    }
  }
}