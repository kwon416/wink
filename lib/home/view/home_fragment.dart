import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wink/toast/flutter_toast.dart';

import '../../authentication/authentication.dart';
import '../../theme/theme.dart';

class HomeFragment extends StatelessWidget {
  const HomeFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme.apply(
      bodyColor: colorScheme.onPrimaryContainer,
      displayColor: colorScheme.onPrimaryContainer,
    );

    return Scaffold(
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
      backgroundColor: Colors.transparent,
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
    );
  }
}
