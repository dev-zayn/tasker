import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/features/tasks/domain/entities/task.dart';

import 'delete_post_btn_widget.dart';
import 'update_post_btn_widget.dart';

class TaskDetailWidget extends StatelessWidget {
  final TaskEntity task;
  const TaskDetailWidget({
    Key? key,
    required this.task,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Due Date: ',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  formatDate(task.dueDate, [yyyy, '-', M, '-', dd]),
                  style: TextStyle(
                    fontSize: 16,
                    color: task.dueDate.isBefore(DateTime.now())
                        ? Colors.red
                        : Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            height: 50,
          ),
          Text(
            task.description,
            textAlign: TextAlign.justify,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 100),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                UpdatePostBtnWidget(post: task),
                DeletePostBtnWidget(postId: task.id!)
              ],
            ),
          )
        ],
      ),
    );
  }
}
