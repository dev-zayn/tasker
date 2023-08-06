import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/features/tasks/domain/entities/task.dart';

import '../../../../core/util/snackbar_message.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../bloc/add_delete_update_task/add_delete_update_task_bloc.dart';
import '../widgets/task_add_update_page/form_widget.dart';

class TaskAddUpdatePage extends StatelessWidget {
  final TaskEntity? task;
  final bool isUpdateTask;
  const TaskAddUpdatePage({Key? key, this.task, required this.isUpdateTask})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: _buildAppbar(),
      body: _buildBody(),
      backgroundColor: Colors.grey[200],
    );
  }

  AppBar _buildAppbar() {
    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }

  Widget _buildBody() {
    return Center(
      child: Padding(
          padding: const EdgeInsets.all(10),
          child:
              BlocConsumer<AddDeleteUpdateTaskBloc, AddDeleteUpdateTaskState>(
            listener: (context, state) {
              log('state is $state');
              if (state is MessageAddDeleteUpdateTaskState) {
                SnackBarMessage().showSuccessSnackBar(
                    message: state.message, context: context);
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/', (Route<dynamic> route) => false);
              } else if (state is ErrorAddDeleteUpdateTaskState) {
                SnackBarMessage().showErrorSnackBar(
                    message: state.message, context: context);
              }
            },
            builder: (context, state) {
              if (state is LoadingAddDeleteUpdateTaskState) {
                return const LoadingWidget();
              }

              return FormWidget(
                  isUpdateTask: isUpdateTask, task: isUpdateTask ? task : null);
            },
          )),
    );
  }
}
