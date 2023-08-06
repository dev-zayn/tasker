import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/core/database/users_database.dart';

import '../models/user_model.dart';

abstract class AuthLocalDataSource {
  Future<UserModel?> login(UserModel userModel);
  Future<UserModel> signup(UserModel userModel);
  Future<Unit> logout();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences sharedPreferences;

  AuthLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<UserModel?> login(UserModel userModel) async {
    UserModel? user = await UsersDatabase.instance.login(userModel);
    log('message');
    if (user != null) {
      final Map<String, dynamic> userToJson = user.toJson();
      log('userToJson $userToJson');
      sharedPreferences.setString('LOGGED_IN_USER', json.encode(userToJson));
      return user;
    } else {
      return null;
    }
  }

  @override
  Future<Unit> logout() {
    sharedPreferences.remove('LOGGED_IN_USER');
    return Future.value(unit);
  }

  @override
  Future<UserModel> signup(UserModel userModel) {
    UsersDatabase.instance.signUp(userModel);
    final Map<String, dynamic> userToJson = userModel.toJson();
    sharedPreferences.setString('LOGGED_IN_USER', json.encode(userToJson));
    return Future.value(userModel);
  }
}
