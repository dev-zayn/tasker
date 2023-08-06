import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:task_manager/features/tasks/domain/entities/task.dart';

import '../../bloc/add_delete_update_task/add_delete_update_task_bloc.dart';
import 'form_submit_btn.dart';
import 'text_form_field_widget.dart';

class FormWidget extends StatefulWidget {
  final bool isUpdateTask;
  final TaskEntity? task;
  const FormWidget({
    Key? key,
    required this.isUpdateTask,
    this.task,
  }) : super(key: key);

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  DateTime _dueDate = DateTime.now().add(const Duration(days: 1));
  @override
  void initState() {
    if (widget.isUpdateTask) {
      _titleController.text = widget.task!.title;
      _bodyController.text = widget.task!.description;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(widget.isUpdateTask ? 'Update Task' : 'Add Task',
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 28,
                      fontWeight: FontWeight.bold)),
            ),
            TextFormFieldWidget(
                name: "Title", multiLines: false, controller: _titleController),
            TextFormFieldWidget(
                name: "Description",
                multiLines: true,
                controller: _bodyController),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: ListTile(
                title: const Text('Due Date'),
                trailing: Text(formatDate(_dueDate, [yyyy, ' ', M, ' ', dd])),
                dense: true,
                tileColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                onTap: () async {
                  DatePicker.showDatePicker(context,
                      showTitleActions: true,
                      minTime: DateTime.now(),
                      maxTime: DateTime.now().add(const Duration(days: 365)),
                      onChanged: (date) {
                    _dueDate = date;
                  }, onConfirm: (date) {
                    _dueDate = date;
                  }, currentTime: DateTime.now(), locale: LocaleType.en);
                },
              ),
            ),
            FormSubmitBtn(
                isUpdatePost: widget.isUpdateTask,
                onPressed: validateFormThenUpdateOrAddPost),
          ]),
    );
  }

  void validateFormThenUpdateOrAddPost() {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final post = TaskEntity(
          id: widget.isUpdateTask ? widget.task!.id : null,
          title: _titleController.text,
          description: _bodyController.text,
          dueDate: _dueDate);

      if (widget.isUpdateTask) {
        BlocProvider.of<AddDeleteUpdateTaskBloc>(context)
            .add(UpdateTaskEvent(task: post));
      } else {
        BlocProvider.of<AddDeleteUpdateTaskBloc>(context)
            .add(AddTaskEvent(task: post));
      }
    }
  }
}
