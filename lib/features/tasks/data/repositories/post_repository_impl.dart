import 'dart:developer';

import 'package:dartz/dartz.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/platform/network_info.dart';
import '../../domain/entities/task.dart';
import '../../domain/repositories/tasks_repository.dart';
import '../datasources/task_local_data_source.dart';
import '../models/task_model.dart';

typedef PostAction = Future<Unit> Function();

class TasksRepositoryImpl implements TasksRepository {
  final TaskLocalDataSource localDataSource;
  final NetworkInfo networkInfo;
  TasksRepositoryImpl(
      {required this.localDataSource, required this.networkInfo});
  @override
  Future<Either<Failure, List<TaskEntity>>> getAllTasks() async {
    try {
      // final localTasks = await TasksDatabase.instance.readAllTasks();
      final localTasks = await localDataSource.getAllTasks();
      return Right(localTasks);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> addTask(TaskEntity task) async {
    final TaskModel taskModel = TaskModel(
        id: task.id,
        title: task.title,
        description: task.description,
        dueDate: task.dueDate);
    try {
      await localDataSource.addTask(taskModel);
      log('here');
      return const Right(unit);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteTask(int id) async {
    try {
      await localDataSource.deleteTask(id);
      return const Right(unit);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updateTask(TaskEntity task) async {
    final TaskModel postModel = TaskModel(
        id: task.id,
        title: task.title,
        description: task.description,
        dueDate: task.dueDate);
    try {
      await localDataSource.updateTask(postModel);
      return const Right(unit);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
