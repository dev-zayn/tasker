import 'package:flutter/material.dart';
import 'package:task_manager/core/theme/app_theme.dart';

class TextFormFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final bool multiLines;
  final String name;
  const TextFormFieldWidget({
    Key? key,
    required this.controller,
    required this.multiLines,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: TextFormField(
          minLines: multiLines ? 6 : 1,
          maxLines: multiLines ? 6 : 1,
          controller: controller,
          validator: (val) => val!.isEmpty ? "$name Can't be empty" : null,
          decoration: InputDecoration(
              hintText: name,
              filled: true,
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: secondaryColor),
                  borderRadius: BorderRadius.circular(10)),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
        ));
  }
}
