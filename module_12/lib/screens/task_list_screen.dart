import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import '../widgets/task_tile.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Khởi tạo tải trước các ảnh thường dùng để tránh giật hình khi render (Exercise 12.2)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      precacheImage(const AssetImage('assets/images/app_logo.png'), context); // [cite: 892, 896]
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Taskly Optimized'), // Sử dụng const tối ưu hóa [cite: 880]
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Khu vực hiển thị logo đã được nạp sẵn cache (Exercise 12.2)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'assets/images/app_logo.png',
              width: 80,
              height: 80,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      labelText: 'What needs to be done?',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    context.read<TaskProvider>().addTask(_controller.text);
                    _controller.clear();
                  },
                  child: const Text('Add'),
                ),
              ],
            ),
          ),
          Expanded(
            // TỐI ƯU HÓA: Sử dụng Selector thay vì Consumer/Watch để chỉ rebuild khi danh sách thay đổi [cite: 879]
            child: Selector<TaskProvider, int>(
              selector: (_, provider) => provider.tasks.length,
              builder: (context, taskCount, _) {
                if (taskCount == 0) {
                  return const Center(
                    child: Text('No tasks yet. Enjoy your day!'),
                  );
                }

                // Trích xuất trực tiếp danh sách từ Provider
                final taskList = context.read<TaskProvider>().tasks;

                return ListView.builder(
                  itemCount: taskCount,
                  itemBuilder: (context, index) {
                    final task = taskList[index];
                    return TaskTile(task: task); // Giao quyền quản lý key và rebuild cho TaskTile [cite: 878, 881]
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}