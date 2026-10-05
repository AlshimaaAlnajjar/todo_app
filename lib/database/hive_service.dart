import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  static late Box box;

  static Future<void> init() async {
    await Hive.initFlutter();
    box = await Hive.openBox('tasks');
  }

  static List getTasks() {
    return box.values.toList();
  }

  static Future addTask(String title) async {
    await box.add({'title': title, 'done': false});
  }

  static Future editTitle(int index, String title) async {
    final task = box.getAt(index);
    await box.putAt(index, {'title': title, 'done': task['done']});
  }

  static Future toggleDone(int index) async {
    final task = box.getAt(index);
    await box.putAt(index, {'title': task['title'], 'done': !task['done']});
  }

  static Future deleteTask(int index) async {
    await box.deleteAt(index);
  }

  static int doneCount() {
    int count = 0;
    for (var task in box.values) {
      if (task['done'] == true) count++;
    }
    return count;
  }
}