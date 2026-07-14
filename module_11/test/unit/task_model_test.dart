import 'package:flutter/material.dart';
import 'package:module_11/repositories/task_repository.dart';
import 'package:module_11/screens/task_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final TaskRepository repository = TaskRepository();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Taskly',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.deepPurple),
      home: TaskListScreen(repository: repository),
    );
  }
}