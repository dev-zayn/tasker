import '../../domain/entities/task.dart';

class TaskModel extends TaskEntity {
  const TaskModel(
      {int? id,
      required String title,
      required String description,
      required DateTime dueDate})
      : super(id: id, title: title, description: description, dueDate: dueDate);
  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      dueDate: DateTime.parse(json['dueDate']),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dueDate': dueDate.toIso8601String()
    };
  }

  TaskModel copy(
          {int? id, String? title, String? description, DateTime? dueDate}) =>
      TaskModel(
          id: id ?? this.id,
          title: title ?? this.title,
          description: description ?? this.description,
          dueDate: dueDate ?? this.dueDate);
}

const String tableTasks = 'tasks';

class TaskFields {
  static final List<String> values = [
    id,
    title,
    description,
    dueDate,
  ];
  static const String id = 'id';
  static const String title = 'title';
  static const String description = 'description';
  static const String dueDate = 'dueDate';
}
