import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:wink/theme/theme_data.dart';
import 'package:wink/theme/theme_manager.dart';
import 'package:wink/toast/flutter_toast.dart';

import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  //runApp()전에 위젯 바인딩 -> 이후에 main()에서 비동기 메소드 사용 가능
  //WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

ThemeManager _themeManager = ThemeManager();

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {


  @override
  void dispose(){
    _themeManager.removeListener(themeListener);
    super.dispose();
  }
  @override
  void initState(){
    super.initState();
    _themeManager.addListener(themeListener);
  }

  themeListener(){
    if(mounted){
      setState(() {

      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter Demo',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: _themeManager.themeMode,
      home: MyHomePage(),
    );

  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  int _selected = 0;
  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme.apply(
      bodyColor: colorScheme.onPrimary,
      displayColor: colorScheme.onPrimary,
    );
    return Stack(
      children: [
        //배경색지정
        Container(color: colorScheme.primary,),

        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: colorScheme.primary,
            elevation: 0.3,
            title: Text('타이틀', style: textTheme.titleLarge,),
            actions: [Switch(value: _themeManager.themeMode == ThemeMode.dark, onChanged: (newValue){
              print(newValue?'lightMode':'darkMode');
              _themeManager.toggleTheme(newValue);
            })],
          ),
          body: SafeArea(
            child: Center(
              // Center is a layout widget. It takes a single child and positions it
              // in the middle of the parent.
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: (){
                      showToast('토스트 띄우기', context);
                    },
                    child: Text('버튼', style: textTheme.labelLarge,),
                  ),
                  Text(
                    '앱 내용',
                    style: textTheme.headlineMedium,
                  ),
                  BlocBuilder<BlocA, BlocAState>(
                    bloc: blocA,
                    buildWhen: (previoisState, state) {

                    },
                    builder: (context, state) {

                    }
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _selected,
            onTap: (selected) {
              setState(() {
                _selected = selected;
              });
            },
            selectedItemColor: colorScheme.onPrimary,
            unselectedItemColor: colorScheme.inversePrimary,
            elevation: 0,
            backgroundColor: Colors.transparent,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  label: "home",
                  backgroundColor: Colors.transparent),
              BottomNavigationBarItem(
                  icon: Icon(Icons.newspaper_outlined),
                  label: "news",
                  backgroundColor: Colors.transparent),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline),
                  label: "person",
                  backgroundColor: Colors.transparent),
              BottomNavigationBarItem(
                  icon: Icon(Icons.notifications_outlined),
                  label: "notification",
                  backgroundColor: Colors.transparent),
            ],
          ),
        ),
      ],
    );
  }
}
