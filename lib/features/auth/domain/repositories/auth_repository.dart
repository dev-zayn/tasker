import 'package:dartz/dartz.dart';
import 'package:task_manager/features/auth/domain/entities/user.dart';

import '../../../../core/error/failures.dart';

abstract class AuthRepository {
  Future<Either<Failure, Unit>> login(UserEntity user);
  Future<Either<Failure, Unit>> signUp(UserEntity user);
  Future<Either<Failure, Unit>> logout();
}
