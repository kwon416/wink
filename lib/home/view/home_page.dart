import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wink/controller/login_controller.dart';
import 'package:wink/controller/membership_controller.dart';
import 'package:wink/home/home.dart';



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
    WinkListFragment(),
    AccountFragment(),
  ];

  final MembershipController m = Get.put(MembershipController());
  final LoginController l = Get.put(LoginController());

  @override
  void dispose(){
    super.dispose();
  }
  @override
  void initState(){
    super.initState();
    String uid = l.getUser().value.uid;
    m.getCurrentUser(uid);
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
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              selectedIconTheme: IconThemeData(size: 30, opacity: 1, color: colorScheme.onPrimaryContainer,),
              unselectedIconTheme: IconThemeData(size: 28, opacity: 0.5, color: colorScheme.primary,),
              selectedLabelStyle: TextStyle(fontSize: 14),
              unselectedLabelStyle: TextStyle(fontSize: 14),
              currentIndex: _selected,
              showUnselectedLabels: true,
              onTap: (selected) {
                setState(() {
                  _selected = selected;
                });
              },
              elevation: 0,
              backgroundColor: Colors.transparent,
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.send_outlined),
                    activeIcon: Icon(Icons.send_rounded),
                    label: "wink 보내기",
                    backgroundColor: Colors.transparent),
                BottomNavigationBarItem(
                    icon: Icon(Icons.call_received_outlined),
                    activeIcon: Icon(Icons.call_received_rounded),
                    label: "받은 wink",
                    backgroundColor: Colors.transparent),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person_outline),
                    activeIcon: Icon(Icons.person_rounded),
                    label: "마이페이지",
                    backgroundColor: Colors.transparent),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
