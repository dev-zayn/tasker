import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/features/auth/domain/entities/user.dart';
import 'package:task_manager/features/auth/domain/use_cases/signup.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/strings/failures.dart';
import '../../../../core/strings/messages.dart';
import '../../domain/use_cases/login.dart';
import '../../domain/use_cases/logout.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUsecase loginUsecase;
  final SignupUsecase signupUsecase;
  final LogoutUsecase logoutUsecase;
  AuthBloc(
      {required this.loginUsecase,
      required this.signupUsecase,
      required this.logoutUsecase})
      : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is LoginEvent) {
        emit(LoadingAuthState());
        final result = await loginUsecase(event.userEntity);
        emit(_mapFailureOrTasksToState(result, LOGIN_SUCCESS_MESSAGE));
      } else if (event is RegisterEvent) {
        emit(LoadingAuthState());
        final result = await signupUsecase(event.userEntity);
        emit(_mapFailureOrTasksToState(result, REGISTER_SUCCESS_MESSAGE));
      } else if (event is LogoutEvent) {
        emit(LoadingAuthState());
        final result = await logoutUsecase();
        emit(_eitherDoneMessageOrErrorState(result, LOGOUT_SUCCESS_MESSAGE));
      }
    });
  }
  String failureMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return UNKNOWN_FAILURE_MESSAGE;
    }
  }

  AuthState _eitherDoneMessageOrErrorState(
      Either<Failure, Unit> either, String message) {
    return either.fold(
      (failure) => ErrorAuthState(
        message: failureMessage(failure),
      ),
      (_) => MessageAuthState(message: message),
    );
  }

  AuthState _mapFailureOrTasksToState(
      Either<Failure, Unit> either, String message) {
    return either.fold(
      (failure) => ErrorAuthState(message: failureMessage(failure)),
      (user) => MessageAuthState(message: message),
    );
  }
}
