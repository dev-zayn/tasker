import 'package:flutter/material.dart';
import 'package:task_manager/features/tasks/domain/entities/task.dart';

import '../../pages/task_detail_page.dart';

class PostListWidget extends StatelessWidget {
  final List<TaskEntity> tasks;
  const PostListWidget({
    Key? key,
    required this.tasks,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: Text(tasks[index].id.toString()),
            title: Text(
              tasks[index].title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              tasks[index].description,
              style: const TextStyle(fontSize: 16),
            ),
            trailing: tasks[index].dueDate.isBefore(DateTime.now())
                ? const Icon(
                    Icons.warning,
                    color: Colors.red,
                  )
                : const Icon(
                    Icons.check,
                    color: Colors.green,
                  ),
            tileColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PostDetailPage(task: tasks[index]),
                ),
              );
            },
          ),
        );
      },
      // separatorBuilder: (context, index) => const Divider(thickness: 1),
    );
  }
}
