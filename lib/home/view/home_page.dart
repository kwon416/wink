import 'package:flutter/material.dart';
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
    SearchFragment(),
    BookingFragment(),
    AccountFragment(),
  ];

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
                    icon: Icon(Icons.home_outlined),
                    activeIcon: Icon(Icons.home_rounded),
                    label: "home",
                    backgroundColor: Colors.transparent),
                BottomNavigationBarItem(
                    icon: Icon(Icons.newspaper_outlined),
                    activeIcon: Icon(Icons.newspaper_rounded),
                    label: "news",
                    backgroundColor: Colors.transparent),
                BottomNavigationBarItem(
                    icon: Icon(Icons.notifications_outlined),
                    activeIcon: Icon(Icons.notifications_rounded),
                    label: "notification",
                    backgroundColor: Colors.transparent),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person_outline),
                    activeIcon: Icon(Icons.person_rounded),
                    label: "person",
                    backgroundColor: Colors.transparent),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
