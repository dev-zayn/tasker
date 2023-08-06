import 'package:dartz/dartz.dart';
import 'package:task_manager/core/error/exception.dart';
import 'package:task_manager/features/auth/data/models/user_model.dart';
import 'package:task_manager/features/auth/domain/entities/user.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/platform/network_info.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_data_source.dart';

typedef PostAction = Future<Unit> Function();

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource localDataSource;
  final NetworkInfo networkInfo;
  AuthRepositoryImpl(
      {required this.localDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, Unit>> login(UserEntity user) async {
    UserModel userModel = UserModel(email: user.email, password: user.password);
    try {
      await localDataSource.login(userModel);
      return const Right(unit);
    } on LoginException {
      return Left(LoginFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> logout() async {
    localDataSource.logout();
    try {
      return const Right(unit);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> signUp(UserEntity user) async {
    UserModel userModel = UserModel(
        email: user.email, title: user.title, password: user.password);
    try {
      await localDataSource.signup(userModel);
      return const Right(unit);
    } on LoginException {
      return Left(LoginFailure());
    }
  }
}
