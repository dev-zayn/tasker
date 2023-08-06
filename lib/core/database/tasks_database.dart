import 'dart:developer';

import 'package:sqflite/sqflite.dart';
import 'package:task_manager/features/tasks/data/models/task_model.dart';

class TasksDatabase {
  static final TasksDatabase instance = TasksDatabase._init();
  static Database? _database;
  TasksDatabase._init();
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('tasks.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    log('initDB');
    final dbPath = await getDatabasesPath();
    final path = dbPath + filePath;
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    db.execute('''CREATE TABLE $tableTasks (
    ${TaskFields.id} $idType,
    ${TaskFields.title} $textType,
    ${TaskFields.description} $textType,
    ${TaskFields.dueDate} $textType
      )''');
  }

  Future<TaskModel> create(TaskModel task) async {
    final db = await instance.database;
    if (task.id == null) {
      int newId = 0;
      await readAllTasks().then((value) => newId = value.length + 1);
      task = TaskModel(
          title: task.title,
          description: task.description,
          dueDate: task.dueDate,
          id: newId);
    }
    log('task ${task.title}');
    log('task ${tableTasks}');
    final id = await db.insert(tableTasks, task.toJson());
    return task.copy(id: id);
  }

  Future<TaskModel> readTask(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      tableTasks,
      columns: TaskFields.values,
      where: '${TaskFields.id} = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return TaskModel.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<TaskModel>> readAllTasks() async {
    final db = await instance.database;
    const orderBy = '${TaskFields.dueDate} ASC';
    final result = await db.query(tableTasks, orderBy: orderBy);
    return result.map((json) => TaskModel.fromJson(json)).toList();
  }

  Future<int> updateTask(TaskModel taskModel) async {
    final db = await instance.database;
    return db.update(tableTasks, taskModel.toJson(),
        where: '${TaskFields.id} = ?', whereArgs: [taskModel.id]);
  }

  Future<int> deleteTask(int id) async {
    final db = await instance.database;
    return await db
        .delete(tableTasks, where: '${TaskFields.id} = ?', whereArgs: [id]);
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
