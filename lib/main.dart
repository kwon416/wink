import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:wink/app.dart';
import 'package:wink/controller/purchase_controller.dart';
import 'package:wink/provider/dynamic_links.dart';
import 'package:wink/provider/wink_list_provider.dart';
import 'package:wink/provider/wink_provider.dart';
import 'package:wink/repository/database_repository/database_repository.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:io';

import 'package:wink/repository/authentication_repository/authentication_repository.dart';

part 'notification_config.dart';


void main() async {
  //runApp()전에 위젯 바인딩 -> 이후에 main()에서 비동기 메소드 사용 가능
  //WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // ***파이어 베이스 메세징 백그라운드 핸들러는 최상위에 위치***
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  //수직 고정 및 statusBar 표시
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);

  if (!kIsWeb) {
    await setupFlutterNotifications();
  }
  if (Platform.isAndroid) {
    await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
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
    Get.put(AuthenticationRepository(), permanent: true);
    Get.put(DatabaseRepository(), permanent: true);
    Get.put(WinkProvider(), permanent: true);
    Get.put(WinkListProvider(), permanent: true);
    Get.put(PurchaseController(), permanent: true);
    // Get.lazyPut<WinkProvider>(() => WinkProvider());
    await 0.delay();
    print('$runtimeType ready!');
    return this;
  }
}

