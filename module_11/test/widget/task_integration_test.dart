import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:module_11/repositories/task_repository.dart';
import 'package:module_11/screens/task_list_screen.dart';

void main() {
  testWidgets('Integration Test: Add, Navigate, Edit, Save, and Verify', (WidgetTester tester) async {
    final repository = TaskRepository();

    await tester.pumpWidget(MaterialApp(
      home: TaskListScreen(repository: repository),
    ));

    // 1. Thêm task với tiêu đề ban đầu [cite: 792, 793]
    await tester.enterText(find.byKey(const Key('taskTextField')), 'Original title');
    await tester.tap(find.byKey(const Key('addTaskButton')));
    await tester.pump();
    expect(find.text('Original title'), findsOneWidget);

    // 2. Chạm vào task để mở màn hình chi tiết [cite: 794]
    await tester.tap(find.text('Original title'));
    await tester.pumpAndSettle();

    // 3. Sửa tiêu đề sang tên mới [cite: 795]
    await tester.enterText(find.byKey(const Key('detailTitleField')), 'Updated title');

    // 4. Lưu lại [cite: 796]
    await tester.tap(find.byKey(const Key('saveTaskButton')));
    await tester.pumpAndSettle();

    // 5. Xác minh tiêu đề mới đã xuất hiện ở danh sách trang chủ [cite: 797]
    expect(find.text('Updated title'), findsOneWidget);
    expect(find.text('Original title'), findsNothing);
  });
}