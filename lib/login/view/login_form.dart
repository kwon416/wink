import 'package:country_calling_code_picker/picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wink/custom_widget/space.dart';
import 'package:wink/login/login.dart';
import 'package:formz/formz.dart';
import 'package:wink/utils/images.dart';
import 'package:wink/utils/widgets.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme.apply(
      bodyColor: colorScheme.onPrimaryContainer,
      displayColor: colorScheme.onPrimaryContainer,
    );

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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Space(60),
                Text("Welcome back!", style: textTheme.displaySmall,),
                Space(8),
                Text("Please Login to your account", style: textTheme.bodyLarge,),
                Space(16),
                Image.asset(splash_logo, width: 100, height: 100, fit: BoxFit.cover),
              ],
            ),
            Space(70),
            _UsernameInput(),
            const Padding(padding: EdgeInsets.all(12)),
            _PasswordInput(),
            const Padding(padding: EdgeInsets.all(12)),

            const Padding(padding: EdgeInsets.all(12)),
            _LoginButton(),

          ],
        ),
      ),
    );
  }
}

class _UsernameInput extends StatefulWidget {
  const _UsernameInput({Key? key}) : super(key: key);

  @override
  State<_UsernameInput> createState() => _UsernameInputState();
}

class _UsernameInputState extends State<_UsernameInput> {
  Country? _selectedCountry;

  @override
  void initState() {
    initCountry();
    super.initState();
  }

  void initCountry() async {
    final country = await getCountryByCountryCode(context, "KR");
    _selectedCountry = country;
    setState(() {});
  }

  bool checkPhoneNumber(String phoneNumber) {
    String regexPattern = r'^(?:[+0][1-9])?[0-9]{10,12}$';
    var regExp = RegExp(regexPattern);

    if (phoneNumber.isEmpty) {
      return false;
    } else if (regExp.hasMatch(phoneNumber)) {
      return true;
    }
    return false;
  }

  void _showCountryPicker() async {
    final country = await showCountryPickerSheet(context);
    if (country != null) {
      setState(() {
        _selectedCountry = country;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return Form(
          key: const Key('loginForm_usernameInput_textField'),
          child: TextFormField(
            keyboardType: TextInputType.phone,
            inputFormatters: [LengthLimitingTextInputFormatter(10)],
            onChanged: (username) => context.read<LoginBloc>().add(LoginUsernameChanged(username)),
            decoration: commonInputDecoration(
              hintText: "전화번호를 입력하세요",
              prefixIcon: Padding(
                padding: EdgeInsets.all(16),
                child: GestureDetector(
                  onTap: () => _showCountryPicker(),
                  child: Text(
                    _selectedCountry == null ? "+82" : _selectedCountry!.callingCode,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
            ),
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
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme.apply(
      bodyColor: colorScheme.onPrimaryContainer,
      displayColor: colorScheme.onPrimaryContainer,
    );

    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? Center(child: CircularProgressIndicator())
            : ElevatedButton(
                key: const Key('loginForm_continue_raisedButton'),
                onPressed: state.status.isValidated
                  ? () {
                    context.read<LoginBloc>().add(const LoginSubmitted());
                    }
                  : null,
          child: Text('로그인', style: textTheme.labelLarge,),
        );
      },
    );
  }
}