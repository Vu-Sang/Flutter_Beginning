import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:module_11/models/task_model.dart';
import 'package:module_11/repositories/task_repository.dart';
import 'package:module_11/screens/task_list_screen.dart';

void main() {
  testWidgets('Should navigate to TaskDetailScreen with proper values when task tapped', (WidgetTester tester) async {
    final repository = TaskRepository();
    // Chèn trước một task vào repo
    repository.addTask(Task(id: '1', title: 'Learn Flutter Testing'));

    await tester.pumpWidget(MaterialApp(
      home: TaskListScreen(repository: repository),
    ));

    // Tap vào phần tử hiển thị trong danh sách
    await tester.tap(find.text('Learn Flutter Testing'));
    await tester.pumpAndSettle(); // Đợi hoạt cảnh chuyển trang hoàn tất

    // Kiểm tra sự xuất hiện của TaskDetailScreen
    expect(find.text('Task Detail'), findsOneWidget);
    expect(find.byKey(const Key('detailTitleField')), findsOneWidget);
  });
}