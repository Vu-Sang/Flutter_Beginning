import 'package:flutter/material.dart';

class AppStructureThemeDemo extends StatelessWidget {
  final bool isDarkMode; // Giữ lại property này để không vỡ code bên main.dart
  final ValueChanged<bool> onThemeChanged;

  const AppStructureThemeDemo({
    super.key,
    required this.isDarkMode,
    required this.onThemeChanged,
  });

  @override
  Widget build(BuildContext context) {
    // Để nhận dạng Dark Mode chính xác nhất trong Material 3, ta nên lấy từ colorScheme
    // vì đôi khi thuộc tính Theme.of(context).brightness không đồng bộ với colorScheme.
    final bool currentIsDarkMode = Theme.of(context).colorScheme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise 4 – App Str...'),
        actions: [
          Row(
            children: [
              const Text('Dark ', style: TextStyle(fontSize: 14)),
              Switch(
                value: currentIsDarkMode,
                onChanged: onThemeChanged,
              ),
              const SizedBox(width: 10),
            ],
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              currentIsDarkMode ? Icons.dark_mode : Icons.light_mode,
              size: 64,
              color: currentIsDarkMode ? Colors.orange : Colors.amber,
            ),
            const SizedBox(height: 16),
            const Text(
              'This is a simple screen with theme toggle.',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Chỉ hiển thị trạng thái hiện tại (ẩn SnackBar cũ nếu người dùng bấm liên tục)
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(currentIsDarkMode ? 'Dark Mode is Active!' : 'Light Mode is Active!')),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}