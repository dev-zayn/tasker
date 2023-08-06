import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/task.dart';

abstract class TasksRepository {
  Future<Either<Failure, List<TaskEntity>>> getAllTasks();
  Future<Either<Failure, Unit>> deleteTask(int id);
  Future<Either<Failure, Unit>> updateTask(TaskEntity post);
  Future<Either<Failure, Unit>> addTask(TaskEntity post);
}
