import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/features/tasks/domain/entities/task.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/strings/failures.dart';
import '../../../../../core/strings/messages.dart';
import '../../../domain/usecases/add_task.dart';
import '../../../domain/usecases/delete_task.dart';
import '../../../domain/usecases/update_task.dart';

part 'add_delete_update_task_event.dart';
part 'add_delete_update_task_state.dart';

class AddDeleteUpdateTaskBloc
    extends Bloc<AddDeleteUpdateTaskEvent, AddDeleteUpdateTaskState> {
  final AddTaskUsecase addTaskUsecase;
  final UpdateTaskUsecase updateTaskUsecase;
  final DeleteTaskUsecase deleteTaskUsecase;
  AddDeleteUpdateTaskBloc(
      {required this.addTaskUsecase,
      required this.updateTaskUsecase,
      required this.deleteTaskUsecase})
      : super(AddDeleteUpdateTaskInitial()) {
    on<AddDeleteUpdateTaskEvent>((event, emit) async {
      if (event is AddTaskEvent) {
        emit(LoadingAddDeleteUpdateTaskState());
        final result = await addTaskUsecase(event.task);
        emit(_eitherDoneMessageOrErrorState(result, ADD_SUCCESS_MESSAGE));
      } else if (event is UpdateTaskEvent) {
        emit(LoadingAddDeleteUpdateTaskState());
        final result = await updateTaskUsecase(event.task);
        emit(_eitherDoneMessageOrErrorState(result, UPDATE_SUCCESS_MESSAGE));
      } else if (event is DeleteTaskEvent) {
        emit(LoadingAddDeleteUpdateTaskState());
        final result = await deleteTaskUsecase(event.taskId);
        emit(_eitherDoneMessageOrErrorState(result, DELETE_SUCCESS_MESSAGE));
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

  AddDeleteUpdateTaskState _eitherDoneMessageOrErrorState(
      Either<Failure, Unit> either, String message) {
    log(either.toString());
    return either.fold(
      (failure) => ErrorAddDeleteUpdateTaskState(
        message: failureMessage(failure),
      ),
      (_) => MessageAddDeleteUpdateTaskState(message: message),
    );
  }
}
