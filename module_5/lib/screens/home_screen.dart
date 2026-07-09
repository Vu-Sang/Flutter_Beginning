import 'package:flutter/material.dart';
import '../models/movie.dart';
import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Biến lưu trữ danh sách phim sau khi lọc tìm kiếm [cite: 210]
  List<Movie> _filteredMovies = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredMovies = sampleMovies; // Ban đầu hiển thị toàn bộ phim
  }

  // Hàm xử lý lọc danh sách phim theo từ khóa nhập vào [cite: 210]
  void _filterMovies(String query) {
    setState(() {
      _filteredMovies = sampleMovies
          .where((movie) => movie.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          // Thanh tìm kiếm phim (Optional Enhancement) [cite: 210]
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search movies...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ),
              onChanged: _filterMovies,
            ),
          ),
          // Danh sách cuộn hiển thị các bộ phim sử dụng ListView.builder
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemCount: _filteredMovies.length,
              itemBuilder: (context, index) {
                final movie = _filteredMovies[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16.0),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
                  elevation: 2,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16.0),
                    // Xử lý sự kiện On Tap điều hướng sang trang Chi tiết bằng Navigator.push [cite: 201, 215]
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailScreen(movie: movie), // Truyền đối tượng Movie qua Screen mới [cite: 204]
                        ),
                      );
                      // Kích hoạt cập nhật lại trạng thái (ví dụ đổi icon Favorite) khi bấm Back quay lại [cite: 223, 228]
                      setState(() {});
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          // Khối hiển thị ảnh Poster phim bo góc [cite: 193]
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12.0),
                            child: Image.network(
                              movie.posterUrl,
                              width: 100,
                              height: 70,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 16),
                          // Khối hiển thị Tiêu đề và Thể loại/Điểm số [cite: 193]
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  movie.title,
                                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Icon(Icons.star_border, size: 16, color: Colors.grey),
                                    const SizedBox(width: 4),
                                    Text('${movie.rating} • ${movie.genres.join(", ")}',
                                        style: const TextStyle(color: Colors.grey, fontSize: 14)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const Icon(Icons.chevron_right, color: Colors.grey),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}