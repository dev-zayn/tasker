part of 'add_delete_update_task_bloc.dart';

abstract class AddDeleteUpdateTaskState extends Equatable {
  const AddDeleteUpdateTaskState();
}

class AddDeleteUpdateTaskInitial extends AddDeleteUpdateTaskState {
  @override
  List<Object> get props => [];
}

class LoadingAddDeleteUpdateTaskState extends AddDeleteUpdateTaskState {
  @override
  List<Object> get props => [];
}

class ErrorAddDeleteUpdateTaskState extends AddDeleteUpdateTaskState {
  final String message;
  const ErrorAddDeleteUpdateTaskState({required this.message});
  @override
  List<Object> get props => [message];
}

class MessageAddDeleteUpdateTaskState extends AddDeleteUpdateTaskState {
  final String message;
  const MessageAddDeleteUpdateTaskState({required this.message});
  @override
  List<Object> get props => [message];
}
