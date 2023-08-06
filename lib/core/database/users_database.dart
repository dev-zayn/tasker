import 'dart:developer';

import 'package:sqflite/sqflite.dart';
import 'package:task_manager/features/auth/data/models/user_model.dart';

class UsersDatabase {
  static final UsersDatabase instance = UsersDatabase._init();
  static Database? _database;
  UsersDatabase._init();
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('users.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    log('initDB users');
    final dbPath = await getDatabasesPath();
    final path = dbPath + filePath;
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const textType = 'TEXT NOT NULL';
    db.execute('''CREATE TABLE $tableUsers (
    ${UserFields.title} $textType,
    ${UserFields.email} $textType,
    ${UserFields.password} $textType
      )''');
  }

  Future<UserModel> signUp(UserModel user) async {
    final db = await instance.database;
    await db.insert(tableUsers, user.toJson());
    return user;
  }

  Future<UserModel?> login(UserModel user) async {
    final db = await instance.database;
    final maps = await db.query(
      tableUsers,
      columns: UserFields.values,
      where: '${UserFields.email} = ? AND ${UserFields.password} = ?',
      whereArgs: [user.email, user.password],
    );
    if (maps.isNotEmpty) {
      log(maps.first.toString(), name: 'login');
      return UserModel.fromJson(maps.first);
    } else {
      return null;
    }
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
