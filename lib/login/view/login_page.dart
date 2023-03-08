import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wink/login/login.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  
  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const LoginPage());
  }

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  double screenHeight = 0.0;
  double screenWidth = 0.0;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

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
          // appBar: AppBar(
          //   backgroundColor: colorScheme.primaryContainer,
          //   title: Text('Login', style: textTheme.titleLarge,),
          // ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(20.0),
            child: BlocProvider(
              create: (context) {
                return LoginBloc(
                  authenticationRepository: RepositoryProvider.of<AuthenticationRepository>(context),
                );
              },
              child: const LoginForm(),
            ),
          ),
        ),
      ],
    );
  }
}
