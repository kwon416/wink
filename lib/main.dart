import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:wink/app.dart';
import 'package:wink/provider/dynamic_links.dart';
import 'package:wink/repository/database_repository/database_repository.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:wink/repository/authentication_repository/authentication_repository.dart';


/// Working example of FirebaseMessaging.
/// Please use this in order to verify messages are working in foreground, background & terminated state.
/// Setup your app following this guide:
/// https://firebase.google.com/docs/cloud-messaging/flutter/client#platform-specific_setup_and_requirements):
///
/// Once you've completed platform specific requirements, follow these instructions:
/// 1. Install melos tool by running `flutter pub global activate melos`.
/// 2. Run `melos bootstrap` in FlutterFire project.
/// 3. In your terminal, root to ./packages/firebase_messaging/firebase_messaging/example directory.
/// 4. Run `flutterfire configure` in the example/ directory to setup your app with your Firebase project.
/// 5. Run the app on an actual device for iOS, android is fine to run on an emulator.
/// 6. Use the following script to send a message to your device: scripts/send-message.js. To run this script,
///    you will need nodejs installed on your computer. Then the following:
///     a. Download a service account key (JSON file) from your Firebase console, rename it to "google-services.json" and add to the example/scripts directory.
///     b. Ensure your device/emulator is running, and run the FirebaseMessaging example app using `flutter run`.
///     c. Copy the token that is printed in the console and paste it here: https://github.com/firebase/flutterfire/blob/01b4d357e1/packages/firebase_messaging/firebase_messaging/example/lib/main.dart#L32
///     c. From your terminal, root to example/scripts directory & run `npm install`.
///     d. Run `npm run send-message` in the example/scripts directory and your app will receive messages in any state; foreground, background, terminated.
///  Note: Flutter API documentation for receiving messages: https://firebase.google.com/docs/cloud-messaging/flutter/receive
///  Note: If you find your messages have stopped arriving, it is extremely likely they are being throttled by the platform. iOS in particular
///  are aggressive with their throttling policy.
///
/// To verify that your messages are being received, you ought to see a notification appearon your device/emulator via the flutter_local_notifications plugin.
/// Define a top-level named handler which background/terminated messages will
/// call. Be sure to annotate the handler with `@pragma('vm:entry-point')` above the function declaration.
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await setupFlutterNotifications();
  //notification이 있으면 백그라운드 알림 뜸
  //notification이 없으면 파이어베이스 알림이 안뜨므로 data로 로컬 노티 생성
  if (message.notification == null) showFlutterNotification(message);
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  print('Handling a background message ${message.messageId}');
}

void onSelectNotification(NotificationResponse notificationResponse) async {
  print('push notification clicked!');
  print(notificationResponse);
  final String? payload = notificationResponse.payload;
  if (notificationResponse.payload != null) {
    debugPrint('notificaiton routing payload: $payload');
    if (payload != null) {
      await Get.toNamed(payload);
    }

  }
  //밑에 푸시 알림 액션 구현
}

/// Create a [AndroidNotificationChannel] for heads up notifications
late AndroidNotificationChannel channel;

bool isFlutterLocalNotificationsInitialized = false;

///Local Notificaion 초기화
Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }
  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description: 'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  ///플랫폼 별 초기화
  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher');
  final DarwinInitializationSettings initializationSettingsDarwin =
  DarwinInitializationSettings(
    //퍼미션 리퀘스트 따로하기 위해서 false
    requestSoundPermission: false,
    requestBadgePermission: false,
    requestAlertPermission: false,
      // onDidReceiveLocalNotification: onDidReceiveLocalNotification
    notificationCategories: [
      //ios는 푸시알림 카테고리를 미리 정의해야 함
      DarwinNotificationCategory(
        'demoCategory',
        actions: <DarwinNotificationAction>[
        DarwinNotificationAction.plain('id_1', 'Action 1'),
        DarwinNotificationAction.plain(
            'id_2',
            'Action 2',
            options: <DarwinNotificationActionOption>{
              DarwinNotificationActionOption.destructive,
            },
          ),
          DarwinNotificationAction.plain(
            'id_3',
            'Action 3',
            options: <DarwinNotificationActionOption>{
              DarwinNotificationActionOption.foreground,
            },
          ),
        ],
        options: <DarwinNotificationCategoryOption>{
          DarwinNotificationCategoryOption.hiddenPreviewShowTitle,
        },
      ),
    ],
  );
  final LinuxInitializationSettings initializationSettingsLinux =
  LinuxInitializationSettings(
      defaultActionName: 'Open notification');
  final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
      macOS: initializationSettingsDarwin,
      linux: initializationSettingsLinux);
  flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    //푸시 알림 클릭 액션 설정
    onDidReceiveNotificationResponse: onSelectNotification,
    onDidReceiveBackgroundNotificationResponse: onSelectNotification,
  );

  /// Create an Android Notification Channel.
  ///
  /// We use this channel in the `AndroidManifest.xml` file to override the
  /// default FCM channel to enable heads up notifications.
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: false,
    badge: true,
    sound: true,
  );
  isFlutterLocalNotificationsInitialized = true;
}

///Custom notifications
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
          icon: '@mipmap/ic_launcher',
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
          badgeNumber: 1,
          //subtitle: 'the subtitle',
          //sound: 'slow_spring_board.aiff',
        ),
      ),
      payload: data['status'],
      // payload: message?.data as String,
    );
  }
}

/// Initialize the [FlutterLocalNotificationsPlugin] package.
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;


void main() async {
  //runApp()전에 위젯 바인딩 -> 이후에 main()에서 비동기 메소드 사용 가능
  //WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // ***파이어 베이스 메세징 백그라운드 핸들러는 최상위에 위치***
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  //수직 고정
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  if (!kIsWeb) {
    await setupFlutterNotifications();
  }

  await initServices(); /// 서비스들 초기화를 기다림.

  // runApp(const MyApp());
  runApp(const App());
}

/// 플러터 앱이 실행되기 전에 서비스들을 초기화하는 현명한 방법입니다.
/// 실행 흐름을 제어 할수 있으므로(테마 구성, apiKey, 사용자가 정의한 언어등을 로드해야 할 필요가 있으므로
/// ApiService의 구동전에 SettingService를 로드해야 합니다.
/// 그래서 GetMaterialApp()은 재구성하지 않고 직접적으로 값을 가져옵니다.
Future<void> initServices() async {
  print('starting services ...');
  /// 여기에서 get_storage, hive, shared_pref 초기화를 하세요.
  /// 또는 연결 고정 또는 비동기적인 무엇이든 하세요.
  await Get.putAsync(() => DbService().init());
  MobileAds.instance.initialize();
  DynamicLinks().setup();
  print('All services started...');
}

class DbService extends GetxService {
  Future<DbService> init() async {
    print('$runtimeType DB init start...');
    Get.put(AuthenticationRepository());
    Get.put(DatabaseRepository());
    await 0.delay();
    print('$runtimeType ready!');
    return this;
  }
}

