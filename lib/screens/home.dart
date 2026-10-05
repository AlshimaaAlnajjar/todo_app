import 'package:flutter/material.dart';
import '../database/hive_service.dart';
import '../widgets/custom_app_bar.dart';
import 'add_task.dart';
import 'edit_task.dart';

class Home extends StatefulWidget {
  final String name;
  Home({required this.name});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final tasks = HiveService.getTasks();
    final done = HiveService.doneCount();

    return Scaffold(
      appBar: CustomAppBar(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF4DB8F5),
        child: Icon(Icons.add, color: Colors.white),
        onPressed: () async {
          String? newTask = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTask()),
          );
          if (newTask != null && newTask != '') {
            await HiveService.addTask(newTask);
            setState(() {});
          }
        },
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Welcome card
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Welcome ${widget.name}', style: TextStyle(fontSize: 16)),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      box('$done', 'Done', Color(0xFF7BC89C)),
                      SizedBox(width: 10),
                      box('${tasks.length - done}', 'To Do', Color(0xFF9B8AFB)),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),

            // empty message or tasks list
            if (tasks.isEmpty)
              Container(
                width: double.infinity,
                height: 120,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('No tasks for today!'),
                    Text('Tap the + button to add your first one.',
                        style: TextStyle(fontSize: 12)),
                  ],
                ),
              )
            else
              Expanded(
                child: ListView(
                  children: [
                    for (int i = 0; i < tasks.length; i++) taskCard(i, tasks[i]),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget box(String number, String text, Color color) {
    return Expanded(
      child: Container(
        height: 90,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(number,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold)),
            Text(text, style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }

  Widget taskCard(int index, Map task) {
    bool isDone = task['done'];

    return GestureDetector(
      onTap: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EditTask(
              index: index,
              title: task['title'],
            ),
          ),
        );
        setState(() {});
      },
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () async {
                    await HiveService.toggleDone(index);
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    decoration: BoxDecoration(
                      color: isDone ? Color(0xFF7BC89C) : Color(0xFF9B8AFB),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(isDone ? 'Done' : 'TODO',
                        style: TextStyle(color: Colors.white, fontSize: 10)),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    await HiveService.deleteTask(index);
                    setState(() {});
                  },
                  child: Icon(Icons.delete_outline, color: Colors.red, size: 22),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(task['title'], style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}