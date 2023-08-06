import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/loading_widget.dart';
import '../bloc/posts/posts_bloc.dart';
import '../widgets/tasks_page/message_display_widget.dart';
import '../widgets/tasks_page/task_list_widget.dart';

class TasksPage extends StatelessWidget {
  const TasksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks',
            style: TextStyle(
                color: Colors.black,
                fontSize: 28,
                fontWeight: FontWeight.bold)),
        centerTitle: false,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Colors.grey[200],
      body: _buildBody(),
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: BlocBuilder<PostsBloc, PostsState>(
        builder: (context, state) {
          if (state is LoadingPostsState) {
            return RefreshIndicator(
                onRefresh: () => _onRefresh(context),
                child: const LoadingWidget());
          } else if (state is LoadedPostsState) {
            return RefreshIndicator(
                onRefresh: () => _onRefresh(context),
                child: PostListWidget(tasks: state.posts));
          } else if (state is ErrorPostsState) {
            return MessageDisplayWidget(message: state.message);
          }
          return const LoadingWidget();
        },
      ),
    );
  }

  // Widget _buildFloatingBtn(BuildContext context) {
  //   return FloatingActionButton(
  //     onPressed: () {
  //       Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //               builder: (_) => const PostAddUpdatePage(
  //                     isUpdatePost: false,
  //                   )));
  //     },
  //     heroTag: 'addTask',
  //     child: const Icon(Icons.add),
  //   );
  // }

  Future<void> _onRefresh(BuildContext context) async {
    BlocProvider.of<PostsBloc>(context).add(RefreshPostsEvent());
  }
}
