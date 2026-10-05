import 'package:flutter/material.dart';
import '../database/hive_service.dart';
import '../widgets/custom_form.dart';

class EditTask extends StatelessWidget {
  final int index;
  final String title;

  const EditTask({required this.index, required this.title});

  @override
  Widget build(BuildContext context) {
    return CustomForm(
      title: 'Edit Task',
      icon: Icons.edit_note,
      hint: 'What needs to be done?',
      buttonText: 'Save changes',
      initialText: title,
      lines: 2,
      onSave: (newTitle) async {
        await HiveService.editTitle(index, newTitle);
        Navigator.pop(context);
      },
    );
  }
}