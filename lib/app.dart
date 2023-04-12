import 'package:authentication_repository/authentication_repository.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:user_repository/user_repository.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:wink/authentication/authentication.dart';
import 'package:wink/home/view/notification_screen.dart';
import 'package:wink/theme/theme.dart';
// import 'package:wink/home/home.dart';
// import 'package:wink/login/login.dart';
import 'package:wink/splash/splash.dart';

import 'main.dart';



class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}
class _AppState extends State<App> {
  late final AuthenticationRepository _authenticationRepository;
  late final UserRepository _userRepository;

  _firebaseMessagingForegroundHandler() {
    ///파이어 베이스 포어 그라운드 푸시 알림 처리
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');
      //TODO 알림으로 보여줄지 스낵바로 보여줄지
      showFlutterNotification(message);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (message.data['payload'] == "notification") {
        Get.to(() => NotificationScreen());
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _authenticationRepository = AuthenticationRepository();
    _userRepository = UserRepository();
    _firebaseMessagingForegroundHandler();
  }

  @override
  void dispose() {
    _authenticationRepository.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authenticationRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationBloc>(
            create: (_) => AuthenticationBloc(
              authenticationRepository: _authenticationRepository,
              userRepository: _userRepository,
            ),
          ),
          BlocProvider<ThemeCubit>(
            create: (_) => ThemeCubit(),
          ),
        ],
        child: const AppView(),
      ),
    );
  }
}



class AppView extends StatefulWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  State<AppView> createState() => _AppViewState();
}
class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  // NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  void dispose(){
    super.dispose();
  }
  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        return GetMaterialApp(
          title: 'Wink app',
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: themeMode,
          navigatorKey: _navigatorKey,

          // builder: (context, child) {
          //   return BlocListener<AuthenticationBloc, AuthenticationState>(
          //     listener: (context, state) {
          //       switch (state.status) {
          //         case AuthenticationStatus.authenticated:
          //           _navigator.pushAndRemoveUntil(
          //             HomePage.route(),
          //             (route) => false,
          //           );
          //           break;
          //         case AuthenticationStatus.unauthenticated:
          //           _navigator.pushAndRemoveUntil(
          //             LoginPage.route(),
          //             (route) => false
          //           );
          //           break;
          //         case AuthenticationStatus.unknown:
          //           break;
          //       }
          //     },
          //     child: child,
          //   );
          // },
          onGenerateRoute: (_) => SplashPage.route(),
        );
      }
    );
  }
}

