import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wink/custom_widget/space.dart';
import 'package:wink/toast/flutter_toast.dart';

import 'package:wink/theme/theme.dart';

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
            Space(12),
            ElevatedButton(
              onPressed: () {},
              child: Text('wink 보내기'),
            ),
            Space(12),
            ElevatedButton(
              onPressed: (){
                showToast('토스트 띄우기', context);
              },
              child: Text('토스트 버튼',),
            ),
          ],
        ),
      ),
    );
  }
}
