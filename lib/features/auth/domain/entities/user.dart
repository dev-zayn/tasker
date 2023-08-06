import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? title;
  final String email;
  final String password;

  const UserEntity({
    this.title,
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [title, email, password];
}
