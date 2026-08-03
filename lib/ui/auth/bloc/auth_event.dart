part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthStarted extends AuthEvent {}

class AuthButtonIsCliked extends AuthEvent {
  final String email;
  final String password;

  const AuthButtonIsCliked(this.email, this.password);
}

class AuthModeChageISClicked extends AuthEvent {}
