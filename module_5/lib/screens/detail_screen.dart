import 'package:flutter/material.dart';
import '../models/movie.dart';

class DetailScreen extends StatefulWidget {
  final Movie movie; // Tiếp nhận đối tượng dữ liệu được truyền sang [cite: 204]

  const DetailScreen({super.key, required this.movie});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Thanh AppBar có chứa nút Back mặc định để quay lại trang chính [cite: 217, 228]
      appBar: AppBar(
        title: Text(widget.movie.title, style: const TextStyle(fontWeight: FontWeight.w500)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context), // Thực hiện quay về bằng cơ chế pop [cite: 228]
        ),
      ),
      // Toàn bộ thân trang bọc trong SingleChildScrollView để đảm bảo cuộn mượt mà không bị lỗi tràn trang
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Khối Hero Banner sử dụng Stack phối Gradient mờ độc đáo
            Stack(
              children: [
                Image.network(
                  widget.movie.posterUrl,
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
                ),
                // Lớp phủ Gradient đen mờ từ dưới lên để làm nổi bật tên phim màu trắng
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withOpacity(0.8),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
                // Text Tiêu đề lớn nằm đè lên góc dưới Banner [cite: 195]
                Positioned(
                  bottom: 16,
                  left: 16,
                  right: 16,
                  child: Text(
                    widget.movie.title,
                    style: const TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),

            // 2. Phân vùng hiển thị danh sách các Genres dạng Chip bao bọc bằng Wrap [cite: 196, 219]
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Wrap(
                spacing: 8.0,
                children: widget.movie.genres.map((genre) {
                  return Chip(
                    label: Text(genre, style: const TextStyle(color: Colors.black54)),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                    backgroundColor: Colors.grey.shade100,
                  );
                }).toList(),
              ),
            ),

            // 3. Đoạn văn mô tả tóm tắt nội dung phim (Overview text) [cite: 197, 220]
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                widget.movie.overview,
                style: const TextStyle(fontSize: 16, height: 1.4),
              ),
            ),
            const SizedBox(height: 20),

            // 4. Hàng nút bấm hành động tương tác (Favorite, Rate, Share) [cite: 198, 221]
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Khối nút Favorite có xử lý thay đổi trạng thái UI động [cite: 209, 223]
                InkWell(
                  onTap: () {
                    setState(() {
                      widget.movie.isFavorite = !widget.movie.isFavorite;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(widget.movie.isFavorite ? 'Added to Favorites!' : 'Removed from Favorites')),
                    );
                  },
                  child: Column(
                    children: [
                      Icon(widget.movie.isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: widget.movie.isFavorite ? Colors.red : Colors.black54),
                      const SizedBox(height: 4),
                      const Text('Favorite', style: TextStyle(color: Colors.black54)),
                    ],
                  ),
                ),
                // Nút Đánh giá (Rate)
                InkWell(
                  onTap: () {},
                  child: const Column(
                    children: [
                      Icon(Icons.star_border, color: Colors.black54),
                      const SizedBox(height: 4),
                      const Text('Rate', style: TextStyle(color: Colors.black54)),
                    ],
                  ),
                ),
                // Nút Chia sẻ (Share)
                InkWell(
                  onTap: () {},
                  child: const Column(
                    children: [
                      Icon(Icons.share, color: Colors.black54),
                      const SizedBox(height: 4),
                      const Text('Share', style: TextStyle(color: Colors.black54)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // 5. Phân vùng danh sách các Video Trailer [cite: 199, 222]
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text('Trailers', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 8),
            // Sử dụng ListView.builder bọc thuộc tính cấu hình thu gọn chiều cao để hiển thị mượt mà trong danh sách cuộn dọc [cite: 199, 222]
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(), // Tắt cuộn độc lập tránh xung đột SingleChildScrollView ngoài
              itemCount: widget.movie.trailers.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.play_circle_fill, color: Colors.black54, size: 32),
                      title: Text(widget.movie.trailers[index], style: const TextStyle(fontSize: 16)),
                      onTap: () {},
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Divider(height: 1),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}