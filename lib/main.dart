import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:wink/app.dart';
import 'package:wink/repository/database_repository/database_repository.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:wink/repository/authentication_repository/authentication_repository.dart';

void main() async {
  //runApp()전에 위젯 바인딩 -> 이후에 main()에서 비동기 메소드 사용 가능
  //WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
  Get.put(AuthenticationRepository());
  Get.put(DatabaseRepository());
  // await Get.putAsync(SettingsService()).init();
  print('All services started...');
}

class DbService extends GetxService {
  Future<DbService> init() async {
    print('$runtimeType delays 2 sec');
    await 2.delay();
    print('$runtimeType ready!');
    return this;
  }
}

// class SettingsService extends GetxService {
//   void init() async {
//     print('$runtimeType delays 1 sec');
//     await 1.delay();
//     print('$runtimeType ready!');
//   }
// }