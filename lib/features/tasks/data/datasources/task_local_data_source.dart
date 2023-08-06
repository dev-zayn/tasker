import 'package:dartz/dartz.dart';

import '../../../../core/database/tasks_database.dart';
import '../models/task_model.dart';

abstract class TaskLocalDataSource {
  Future<Unit> deleteTask(int id);
  Future<Unit> updateTask(TaskModel taskModel);
  Future<Unit> addTask(TaskModel taskModel);
  Future<List<TaskModel>> getAllTasks();
}

class TaskLocalDataSourceImpl implements TaskLocalDataSource {
  TaskLocalDataSourceImpl();

  @override
  Future<Unit> addTask(TaskModel taskModel) {
    TasksDatabase.instance.create(taskModel);
    return Future.value(unit);
  }

  @override
  Future<Unit> deleteTask(int id) {
    TasksDatabase.instance.deleteTask(id);
    return Future.value(unit);
  }

  @override
  Future<List<TaskModel>> getAllTasks() {
    return TasksDatabase.instance.readAllTasks();
  }

  @override
  Future<Unit> updateTask(TaskModel taskModel) {
    TasksDatabase.instance.updateTask(taskModel);
    return Future.value(unit);
  }
}
