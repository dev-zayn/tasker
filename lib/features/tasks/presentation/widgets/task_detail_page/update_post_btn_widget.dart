import 'package:flutter/material.dart';
import 'package:task_manager/features/tasks/domain/entities/task.dart';

import '../../pages/task_add_update_page.dart';

class UpdatePostBtnWidget extends StatelessWidget {
  final TaskEntity post;
  const UpdatePostBtnWidget({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'addTask',
      child: ElevatedButton.icon(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => TaskAddUpdatePage(
                  isUpdateTask: true,
                  task: post,
                ),
              ));
        },
        icon: const Icon(Icons.edit),
        label: const Text("Edit"),
      ),
    );
  }
}
