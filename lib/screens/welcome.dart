import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/custom_form.dart';
import 'home.dart';

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomForm(
      title: "Let's get started",
      subtitle: 'What should we call you?',
      hint: 'Your name',
      buttonText: 'Save',
      onSave: (name) async {
        final prefs = await SharedPreferences.getInstance();
        bool ok = await prefs.setString('name', name);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Home(name: name)),
        );
      },
    );
  }
}