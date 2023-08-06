import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task_manager/features/tasks/domain/entities/task.dart';

import '../widgets/task_detail_page/post_detail_widget.dart';

class PostDetailPage extends StatelessWidget {
  final TaskEntity task;
  const PostDetailPage({
    Key? key,
    required this.task,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: _buildAppbar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppbar() {
    return AppBar(
      title: Text(task.title,
          style: const TextStyle(
              color: Colors.black, fontSize: 28, fontWeight: FontWeight.bold)),
      centerTitle: false,
      leading: const SizedBox.shrink(),
      actions: [
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Text(
                '${DateTime.now().difference(task.dueDate).inDays} days left',
                style: const TextStyle(
                    color: Colors.orangeAccent,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)))
      ],
      leadingWidth: 0,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }

  Widget _buildBody() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: TaskDetailWidget(task: task),
      ),
    );
  }
}
