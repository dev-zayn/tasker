import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class SignupUsecase {
  final AuthRepository repository;

  SignupUsecase(this.repository);

  Future<Either<Failure, Unit>> call(UserEntity user) async {
    return await repository.signUp(user);
  }
}
