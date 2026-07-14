import 'package:flutter_test/flutter_test.dart';
import 'package:module_11/models/task_model.dart';
import 'package:module_11/repositories/task_repository.dart';

void main() {
  group('Task Repository Unit Tests', () {
    late TaskRepository repository;

    setUp(() {
      repository = TaskRepository();
    });

    // Kiểm tra tính năng thêm task [cite: 753]
    test('addTask should append task to list', () {
      final task = Task(id: '1', title: 'Task 1');
      repository.addTask(task);

      expect(repository.tasks.length, 1);
      expect(repository.tasks.first.title, 'Task 1');
    });

    // Kiểm tra tính năng xóa task [cite: 754]
    test('deleteTask should remove correct task', () {
      final task1 = Task(id: '1', title: 'Task 1');
      final task2 = Task(id: '2', title: 'Task 2');
      repository.addTask(task1);
      repository.addTask(task2);

      repository.deleteTask('1');

      expect(repository.tasks.length, 1);
      expect(repository.tasks.first.id, '2');
    });

    // Kiểm tra tính năng cập nhật task [cite: 755]
    test('updateTask should edit correct task title', () {
      final task = Task(id: '1', title: 'Old Title');
      repository.addTask(task);

      repository.updateTask('1', 'New Title');

      expect(repository.tasks.first.title, 'New Title');
    });
  });
}