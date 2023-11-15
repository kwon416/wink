// part of 'login_bloc.dart';
//
//
// abstract class LoginEvent extends Equatable {
//   const LoginEvent();
//
//   @override
//   List<Object> get props => [];
// }
//
// ///사용자 이름 수정
// class LoginUsernameChanged extends LoginEvent {
//   const LoginUsernameChanged(this.username);
//
//   final String username;
//
//   @override
//   List<Object> get props => [username];
// }
//
// ///사용자 패스워드 수정
// class LoginPasswordChanged extends LoginEvent {
//   const LoginPasswordChanged(this.password);
//
//   final String password;
//
//   @override
//   List<Object> get props => [password];
// }
//
// ///로그인 양식 제출
// class LoginSubmitted extends LoginEvent {
//   const LoginSubmitted();
// }