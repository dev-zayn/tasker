import 'package:flutter/material.dart';

import '../../../../../core/theme/app_theme.dart';

class FormSubmitBtn extends StatelessWidget {
  final void Function() onPressed;
  final bool isUpdatePost;

  const FormSubmitBtn({
    Key? key,
    required this.onPressed,
    required this.isUpdatePost,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        child: ElevatedButton.icon(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
                primary: secondaryColor,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                textStyle:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            icon: isUpdatePost
                ? const Icon(
                    Icons.edit,
                  )
                : const Icon(
                    Icons.add,
                  ),
            label: Text(
              isUpdatePost ? "Update Task" : "Add Task",
              style: const TextStyle(),
            )),
      ),
    );
  }
}
