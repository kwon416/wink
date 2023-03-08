import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wink/login/login.dart';
import 'package:formz/formz.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(const SnackBar(content: Text('로그인 실패'))
            );
        }
      },
      child: Align(
        alignment: const Alignment(0, -1/3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _UsernameInput(),
            const Padding(padding: EdgeInsets.all(12)),
            _PasswordInput(),
            const Padding(padding: EdgeInsets.all(12)),
            _LoginButton(),
          ],
        ),
      ),
    );
  }
}

class _UsernameInput extends StatelessWidget {
  const _UsernameInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return TextField(
          key: const Key('loginForm_usernameInput_textField'),
          onChanged: (username) => context.read<LoginBloc>().add(LoginUsernameChanged(username)),
          decoration: InputDecoration(
            labelText: '이메일 또는 전화번호',
            errorText: state.username.invalid ? '유효하지 않은 이메일 또는 전화번호입니다' : null,
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          key: const Key('loginForm_passwordInput_textField'),
          onChanged: (password) =>
              context.read<LoginBloc>().add(LoginPasswordChanged(password)),
          obscureText: true,
          decoration: InputDecoration(
            labelText: '비밀번호',
            errorText: state.password.invalid ? '유효하지 않은 비밀번호입니다' : null,
          ),
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
          key: const Key('loginForm_continue_raisedButton'),
          onPressed: state.status.isValidated
              ? () {
            context.read<LoginBloc>().add(const LoginSubmitted());
          }
              : null,
          child: const Text('로그인'),
        );
      },
    );
  }
}