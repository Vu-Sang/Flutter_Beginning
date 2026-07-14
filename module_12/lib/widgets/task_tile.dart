import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task_model.dart';
import '../providers/task_provider.dart';

// Tránh rebuild toàn bộ danh sách bằng cách đóng gói widget con độc lập
class TaskTile extends StatelessWidget {
  final Task task;

  // Sử dụng ValueKey để Flutter tái định danh widget hiệu quả khi thêm/xóa phần tử
  TaskTile({required this.task}) : super(key: ValueKey(task.id));
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: ListTile(
        title: Text(
          task.title,
          style: TextStyle(
            decoration: task.isCompleted ? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Checkbox(
              value: task.isCompleted,
              onChanged: (_) {
                // Đọc provider không lắng nghe rebuild ở cấp độ ListTile này
                Provider.of<TaskProvider>(context, listen: false).toggleTask(task.id);
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                Provider.of<TaskProvider>(context, listen: false).deleteTask(task.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}