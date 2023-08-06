import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/task.dart';
import '../repositories/tasks_repository.dart';

class GetAllTasksUseCase {
  final TasksRepository repository;

  GetAllTasksUseCase(this.repository);

  Future<Either<Failure, List<TaskEntity>>> call() async {
    return await repository.getAllTasks();
  }
}
