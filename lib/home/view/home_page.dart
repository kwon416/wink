import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wink/authentication/authentication.dart';
import 'package:wink/theme/cubit/theme_cubit.dart';
import 'package:wink/toast/flutter_toast.dart';


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

    return Stack(
      children: [
        Container(color: colorScheme.primaryContainer,),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: colorScheme.primaryContainer,
            elevation: 0.3,
            title: Text('Home', style: textTheme.titleLarge,),
            actions: [
              Switch(
                value: context.watch<ThemeCubit>().state == ThemeMode.dark,
                onChanged: (newValue){
              context.read<ThemeCubit>().toggleTheme(newValue);
            }),
            ],
          ),
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Builder(
                  builder: (context) {
                    final userId = context.select(
                      (AuthenticationBloc bloc) => bloc.state.user.id,
                    );
                    return Text('UserId: $userId', style: textTheme.bodyMedium,);
                  }
                ),
                const Padding(padding: EdgeInsets.all(12)),
                ElevatedButton(
                  onPressed: () {
                    context.read<AuthenticationBloc>().add(AuthenticationLogoutRequested());
                  },
                  child: Text('로그아웃'),
                ),
                const Padding(padding: EdgeInsets.all(12)),
                ElevatedButton(
                  onPressed: (){
                    showToast('토스트 띄우기', context);
                  },
                  child: Text('버튼',),
                ),
              ],
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _selected,
            onTap: (selected) {
              setState(() {
                _selected = selected;
              });
            },
            selectedItemColor: colorScheme.onPrimaryContainer,
            unselectedItemColor: colorScheme.primary,
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
