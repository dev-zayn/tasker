part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}

class LoadingAuthState extends AuthState {
  @override
  List<Object> get props => [];
}

class LoadedAuthState extends AuthState {
  final UserEntity userEntity;
  const LoadedAuthState({required this.userEntity});
  @override
  List<Object> get props => [userEntity];
}

class ErrorAuthState extends AuthState {
  final String message;
  const ErrorAuthState({required this.message});
  @override
  List<Object> get props => [message];
}

class MessageAuthState extends AuthState {
  final String message;
  const MessageAuthState({required this.message});
  @override
  List<Object> get props => [message];
}
