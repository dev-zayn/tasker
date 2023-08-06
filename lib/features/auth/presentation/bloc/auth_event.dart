part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class LoginEvent extends AuthEvent {
  final UserEntity userEntity;
  const LoginEvent({required this.userEntity});
  @override
  List<Object> get props => [userEntity];
}

class RegisterEvent extends AuthEvent {
  final UserEntity userEntity;
  const RegisterEvent({required this.userEntity});
  @override
  List<Object> get props => [userEntity];
}

class LogoutEvent extends AuthEvent {
  @override
  List<Object> get props => [];
}
