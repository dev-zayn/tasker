part of 'add_delete_update_task_bloc.dart';

abstract class AddDeleteUpdateTaskEvent extends Equatable {
  const AddDeleteUpdateTaskEvent();

  @override
  List<Object> get props => [];
}

class AddTaskEvent extends AddDeleteUpdateTaskEvent {
  final TaskEntity task;

  const AddTaskEvent({required this.task});

  @override
  List<Object> get props => [task];
}

class UpdateTaskEvent extends AddDeleteUpdateTaskEvent {
  final TaskEntity task;

  const UpdateTaskEvent({required this.task});

  @override
  List<Object> get props => [task];
}

class DeleteTaskEvent extends AddDeleteUpdateTaskEvent {
  final int taskId;

  const DeleteTaskEvent({required this.taskId});

  @override
  List<Object> get props => [taskId];
}
