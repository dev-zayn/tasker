import 'package:equatable/equatable.dart';

class TaskEntity extends Equatable {
  final int? id;
  final String title;
  final String description;
  final DateTime dueDate;

  const TaskEntity({
    this.id,
    required this.title,
    required this.description,
    required this.dueDate,
  });

  @override
  List<Object?> get props => [id, title, description, dueDate];
}
