import '../../domain/entities/user.dart';

class UserModel extends UserEntity {
  const UserModel(
      {String? title, required String email, required String password})
      : super(title: title, email: email, password: password);
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        title: json['title'], email: json['email'], password: json['password']);
  }
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'email': email,
      'password': password,
    };
  }

  UserModel copy({String? title, String? email, String? password}) => UserModel(
        title: title ?? this.title,
        email: email ?? this.email,
        password: password ?? this.password,
      );
}

const String tableUsers = 'users';

class UserFields {
  static final List<String> values = [title, email, password];
  static const String title = 'title';
  static const String email = 'email';
  static const String password = 'password';
}
