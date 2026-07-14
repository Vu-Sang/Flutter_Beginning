import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:module_11/repositories/task_repository.dart';
import 'package:module_11/screens/task_list_screen.dart';

void main() {
  group('TaskListScreen Widget Tests', () {
    late TaskRepository repository;

    setUp(() {
      repository = TaskRepository();
    });

    // 1. Kiểm tra hiển thị màn hình trống [cite: 767]
    testWidgets('Should display empty state when there are no tasks', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: TaskListScreen(repository: repository),
      ));

      expect(find.text('No tasks yet. Add one!'), findsOneWidget); // [cite: 767]
    });

    // 2. Kiểm tra việc thêm một task mới [cite: 768]
    testWidgets('Should add a task and display it in the list', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: TaskListScreen(repository: repository),
      ));

      await tester.enterText(find.byKey(const Key('taskTextField')), 'Buy Milk'); // [cite: 770]
      await tester.tap(find.byKey(const Key('addTaskButton'))); // [cite: 770]
      await tester.pump(); // Cập nhật lại UI [cite: 770]

      expect(find.text('Buy Milk'), findsOneWidget);
      expect(find.text('No tasks yet. Add one!'), findsNothing);
    });

    // 3. Kiểm tra hiển thị nhiều tasks [cite: 769]
    testWidgets('Should display multiple tasks correctly', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: TaskListScreen(repository: repository),
      ));

      // Thêm task 1
      await tester.enterText(find.byKey(const Key('taskTextField')), 'Task 1');
      await tester.tap(find.byKey(const Key('addTaskButton')));
      await tester.pump();

      // Thêm task 2
      await tester.enterText(find.byKey(const Key('taskTextField')), 'Task 2');
      await tester.tap(find.byKey(const Key('addTaskButton')));
      await tester.pump();

      expect(find.text('Task 1'), findsOneWidget);
      expect(find.text('Task 2'), findsOneWidget);
    });
  });
}