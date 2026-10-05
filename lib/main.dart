import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'database/hive_service.dart';
import 'screens/welcome.dart';
import 'screens/home.dart';

void main() async {
  // needed before reading anything when the app starts
  WidgetsFlutterBinding.ensureInitialized();

  //hive (edit tasks)
  await HiveService.init();

  // shared preferences (name + tasks)
  final prefs = await SharedPreferences.getInstance();
  final name = prefs.getString('name');
  print('saved name = $name');

  //لو حابين نحذف
  //await prefs.remove('name');
  //await prefs.clear();

  //لو حابين نعدل
  //prefs.setString('name','    ');

  runApp(MyApp(name: name));
}

class MyApp extends StatelessWidget {
  final String? name;
  MyApp({this.name});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFFFFE8E8),
      ),
      home: name == null ? Welcome() : Home(name: name!),
    );
  }
}