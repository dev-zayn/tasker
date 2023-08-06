import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../repositories/tasks_repository.dart';

class DeleteTaskUsecase {
  final TasksRepository repository;

  DeleteTaskUsecase(this.repository);

  Future<Either<Failure, Unit>> call(int id) async {
    return await repository.deleteTask(id);
  }
}
