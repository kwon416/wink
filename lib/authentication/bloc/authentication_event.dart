part of 'authentication_bloc.dart';

abstract class AuthenticationEvent {
  const AuthenticationEvent();
}
///유저 AuthenticationStatus의 변화
class _AuthenticationStatusChanged extends AuthenticationEvent {
  const _AuthenticationStatusChanged(this.status);

  final AuthenticationStatus status;
}

///유저 로그아웃 리퀘스트
class AuthenticationLogoutRequested extends AuthenticationEvent {}