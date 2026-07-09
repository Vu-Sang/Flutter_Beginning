import 'package:flutter/material.dart';

class CommonUIFixesDemo extends StatelessWidget {
  const CommonUIFixesDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Exercise 5 – Common U...')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Correct ListView inside Column using Expanded',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 250,
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                children: const [
                  ListTile(leading: Icon(Icons.movie), title: Text('Movie A')),
                  ListTile(leading: Icon(Icons.movie), title: Text('Movie B')),
                  ListTile(leading: Icon(Icons.movie), title: Text('Movie C')),
                  ListTile(leading: Icon(Icons.movie), title: Text('Movie D')),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 10),
            const Text(
              '📝 Báo Cáo Giải Trình Mã Lỗi (Exercise 5 Fixes):',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue),
            ),
            const SizedBox(height: 8),
            const Text(
              '1. Lỗi ListView trong Column: Do Column không giới hạn chiều cao dọc, còn ListView mặc định chiếm vô hạn không gian. Khắc phục: Giới hạn chiều cao bằng SizedBox hoặc Expanded.\n\n'
                  '2. Lỗi Overflow màn hình nhỏ: Khi nội dung vượt quá kích thước vật lý màn hình, Flutter báo sọc vàng đen. Khắc phục: Bọc layout gốc bằng SingleChildScrollView để cho phép cuộn.\n\n'
                  '3. Lỗi không cập nhật giao diện: Thay đổi biến nhưng không bọc trong hàm setState() của StatefulWidget khiến Widget Tree không kích hoạt vẽ lại. Khắc phục: Luôn gọi setState().\n\n'
                  '4. Lỗi BuildContext của Picker: Truyền sai context chưa thuộc nhánh cây hợp lệ. Khắc phục: Sử dụng BuildContext chính xác từ hàm build của lớp hiển thị.',
              style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }
}