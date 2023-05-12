import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:wink/controller/membership_controller.dart';
import 'package:wink/home/home.dart';
import 'package:wink/main.dart';
import 'package:wink/utils/constant.dart';



class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);


  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const HomePage());
  }

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selected = 0;

  DateTime? _currentBackPressTime;

  final _pageItem = [
    HomeFragment(),
    WinkBoxFragment(),
    AccountFragment(),
  ];

  final MembershipController m = Get.put(MembershipController());
  // final LoginController l = Get.put(LoginController());

  ///파이어베이스 알림 권한 요청 + fcmToken 관리
  void initializeNotification() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    print('User granted permission: ${settings.authorizationStatus}');

    FirebaseMessaging.instance.getToken().then((token){
      print("get FCM token : ${token ?? 'token NULL!'}");
      // FCM 토큰을 서버에 저장 👈👈👈👈👈👈👈👈👈👈👈
      // if(token != null) m.updateFcmToken(l.getUser().value.uid, token);
      if(token != null) m.updateFcmToken(m.uid, token);
      // client.post(Uri.parse(Constants.API + 'booster/v1/fcm-token'), body: jsonEncode({ 'fcmToken': "$token" }));
    });

    FirebaseMessaging.instance.onTokenRefresh.listen((token) {
      print("on refresh FCM token : $token");
      // m.updateFcmToken(l.getUser().value.uid, token);
      m.updateFcmToken(m.uid, token);
      // FCM 토큰을 서버에 저장 👈👈👈👈👈👈👈👈👈👈👈
      // client.post(Uri.parse(Constants.API + 'booster/v1/fcm-token'), body: jsonEncode({ 'fcmToken': "$token" }));
    });

  }

  Future<void>  _firebaseMessagingForegroundHandler() async {
    RemoteMessage? initialMessage =
    await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    ///파이어 베이스 포어 그라운드 푸시 알림 처리
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');
      //TODO 알림으로 보여줄지 스낵바로 보여줄지
      //
      showFlutterNotification(message);
    });
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  void _handleMessage(RemoteMessage message) {
    if (message.data['status'] != null) {
      Get.toNamed('${message.data['status']}');

    }
  }

  @override
  void dispose(){
    super.dispose();
  }
  @override
  void initState(){
    super.initState();

    _firebaseMessagingForegroundHandler();
    initializeNotification();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    // String uid = l.getUser().value.uid;
    // await m.getCurrentUser(uid);

    // initializeNotification();
  }


  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme.apply(
      bodyColor: colorScheme.onPrimaryContainer,
      displayColor: colorScheme.onPrimaryContainer,
    );

    return WillPopScope(
      onWillPop: () {
        DateTime now = DateTime.now();

        if (_currentBackPressTime == null || now.difference(_currentBackPressTime!) > Duration(seconds: 2)) {
          _currentBackPressTime = now;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Press back again to exit'),
            ),
          );

          return Future.value(false);
        }
        return Future.value(true);
      },
      child: Stack(
        children: [
          Container(color: colorScheme.primaryContainer,),
          Scaffold(
            backgroundColor: Colors.transparent,
            body: _pageItem[_selected],
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: colorScheme.onPrimaryContainer,
                    width: 0.5
                  )
                ),
              ),
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: colorScheme.onPrimaryContainer,
                selectedIconTheme: IconThemeData(size: 30, opacity: 1, color: colorScheme.onPrimaryContainer,),
                unselectedIconTheme: IconThemeData(size: 28, opacity: 0.5, color: colorScheme.primary,),
                selectedLabelStyle: TextStyle(fontSize: textSizeSMedium),
                unselectedLabelStyle: TextStyle(fontSize: textSizeSMedium),
                currentIndex: _selected,
                showUnselectedLabels: true,
                onTap: (selected) {
                  setState(() {
                    _selected = selected;
                  });
                },
                elevation: 0,
                backgroundColor: Colors.transparent,
                items: [
                  BottomNavigationBarItem(
                      // icon: Icon(Icons.send_outlined),
                      icon: FaIcon(FontAwesomeIcons.paperPlane),
                      // activeIcon: Icon(Icons.send_rounded),
                      activeIcon: FaIcon(FontAwesomeIcons.paperPlane),
                      label: "Send WINK".tr,
                      backgroundColor: Colors.transparent),
                  BottomNavigationBarItem(
                      // icon: Icon(Icons.call_received_outlined),
                      icon: FaIcon(FontAwesomeIcons.box),
                      // activeIcon: Icon(Icons.call_received_rounded),
                      activeIcon: FaIcon(FontAwesomeIcons.box),
                      label: "WINK Box".tr,
                      backgroundColor: Colors.transparent),
                  BottomNavigationBarItem(
                      // icon: Icon(Icons.person_outline),
                      icon: FaIcon(FontAwesomeIcons.user),
                      // activeIcon: Icon(Icons.person_rounded),
                      activeIcon: FaIcon(FontAwesomeIcons.user),
                      label: "Profile".tr,
                      backgroundColor: Colors.transparent),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
