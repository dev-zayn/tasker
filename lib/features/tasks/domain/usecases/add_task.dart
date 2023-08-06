import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/task.dart';
import '../repositories/tasks_repository.dart';

class AddTaskUsecase {
  final TasksRepository repository;

  AddTaskUsecase(this.repository);

  Future<Either<Failure, Unit>> call(TaskEntity task) async {
    return await repository.addTask(task);
  }
}
