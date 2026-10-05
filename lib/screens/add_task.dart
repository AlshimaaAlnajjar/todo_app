import 'package:flutter/material.dart';
import '../widgets/custom_form.dart';

class AddTask extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomForm(
      title: 'Add Task',
      icon: Icons.post_add,
      hint: 'What needs to be done?',
      buttonText: 'Save',
      onSave: (title) {
        Navigator.pop(context, title);
      },
    );
  }
}