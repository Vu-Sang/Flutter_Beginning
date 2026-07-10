import 'package:flutter/material.dart';

void main() {
  runApp(const ResponsiveMovieApp());
}

// ============================================================================
// STEP 2: ĐỊNH NGHĨA MODEL CẤU TRÚC DỮ LIỆU & BỘ DỮ LIỆU MẪU TĨNH
// ============================================================================
class Movie {
  final String title;
  final int year;
  final List<String> genres;
  final String posterUrl;
  final double rating;

  const Movie({
    required this.title,
    required this.year,
    required this.genres,
    required this.posterUrl,
    required this.rating,
  });
}

// Danh sách các bộ phim mẫu tĩnh phục vụ bộ lọc (3-6 items) [cite: 303]
const List<Movie> allMovies = [
  Movie(
    title: 'Dune: Part Two',
    year: 2024,
    genres: ['Sci-Fi', 'Adventure', 'Drama'],
    posterUrl: 'https://picsum.photos/id/10/400/250',
    rating: 8.6,
  ),
  Movie(
    title: 'Deadpool & Wolverine',
    year: 2024,
    genres: ['Action', 'Comedy', 'Sci-Fi'],
    posterUrl: 'https://picsum.photos/id/20/400/250',
    rating: 8.3,
  ),
  Movie(
    title: 'Inception',
    year: 2010,
    genres: ['Action', 'Sci-Fi', 'Adventure'],
    posterUrl: 'https://picsum.photos/id/30/400/250',
    rating: 8.8,
  ),
  Movie(
    title: 'The Dark Knight',
    year: 2008,
    genres: ['Action', 'Drama', 'Crime'],
    posterUrl: 'https://picsum.photos/id/40/400/250',
    rating: 9.0,
  ),
  Movie(
    title: 'Interstellar',
    year: 2014,
    genres: ['Sci-Fi', 'Drama', 'Adventure'],
    posterUrl: 'https://picsum.photos/id/50/400/250',
    rating: 8.7,
  ),
  Movie(
    title: 'The Hangover',
    year: 2009,
    genres: ['Comedy'],
    posterUrl: 'https://picsum.photos/id/60/400/250',
    rating: 7.7,
  ),
];

// ============================================================================
// STEP 3: KHỞI TẠO ROOT APP WIDGET
// ============================================================================
class ResponsiveMovieApp extends StatelessWidget {
  const ResponsiveMovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Responsive Movie Browser',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const GenreScreen(), // Trỏ trang chủ về giao diện GenreScreen [cite: 307]
    );
  }
}

// ============================================================================
// STATEFUL WIDGET ĐIỀU KHIỂN CHÍNH MÀN HÌNH BROWSER
// ============================================================================
class GenreScreen extends StatefulWidget {
  const GenreScreen({super.key});

  @override
  State<GenreScreen> createState() => _GenreScreenState();
}

class _GenreScreenState extends State<GenreScreen> {
  // --- CÁC BIẾN QUẢN LÝ TRẠNG THÁI (STATE VARIABLES) ---
  String _searchQuery = ''; // Lưu từ khóa tìm kiếm [cite: 314]
  final Set<String> _selectedGenres = {}; // Lưu danh sách thể loại đang chọn lọc [cite: 319]
  String _selectedSort = 'A–Z'; // Cấu hình sắp xếp mặc định [cite: 327]

  // Danh mục danh sách thể loại cứng dùng để render các Chips [cite: 318]
  final List<String> _availableGenres = [
    'Action',
    'Comedy',
    'Drama',
    'Sci-Fi',
    'Adventure',
    'Crime'
  ];

  // Danh sách các tùy chọn cho Dropdown Button sắp xếp [cite: 326]
  final List<String> _sortOptions = ['A–Z', 'Z–A', 'Year', 'Rating'];

  @override
  Widget build(BuildContext context) {
    // ========================================================================
    // STEP 7: LOGIC LỌC DỮ LIỆU (FILTERING) & SẮP XẾP (SORTING) BẤT ĐỒNG BỘ
    // ========================================================================
    List<Movie> visibleMovies = allMovies.where((movie) {
      // 1. Lọc theo từ khóa tìm kiếm trong tiêu đề (Không phân biệt hoa thường) [cite: 270, 335]
      final matchesSearch = movie.title.toLowerCase().contains(_searchQuery.toLowerCase());

      // 2. Lọc theo Thể loại được chọn (Nếu có chọn, phim phải chứa ít nhất 1 thể loại thỏa mãn) [cite: 271]
      final matchesGenre = _selectedGenres.isEmpty ||
          movie.genres.any((genre) => _selectedGenres.contains(genre));

      return matchesSearch && matchesGenre;
    }).toList();

    // 3. Tiến hành sắp xếp danh sách kết quả hiển thị dựa vào giá trị Dropdown [cite: 329, 334]
    if (_selectedSort == 'A–Z') {
      visibleMovies.sort((a, b) => a.title.compareTo(b.title));
    } else if (_selectedSort == 'Z–A') {
      visibleMovies.sort((a, b) => b.title.compareTo(a.title));
    } else if (_selectedSort == 'Year') {
      visibleMovies.sort((a, b) => b.year.compareTo(a.year)); // Phim mới hơn xếp trước
    } else if (_selectedSort == 'Rating') {
      visibleMovies.sort((a, b) => b.rating.compareTo(a.rating)); // Điểm cao xếp trước
    }

    return Scaffold(
      body: SafeArea(
        // SafeArea giúp tránh đè vào tai thỏ, camera nốt ruồi của điện thoại [cite: 279, 308]
        child: Padding(
          padding: const EdgeInsets.all(16.0), // Spacing lề đồng nhất [cite: 308]
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- LAB 6.1: RESPONSIVE HERO & HEADING SECTION ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Find a Movie', // Tiêu đề bắt buộc của ứng dụng [cite: 257, 310]
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  // Phần mở rộng bonus: Hiển thị Badge số lượng thể loại đang chọn [cite: 287]
                  if (_selectedGenres.isNotEmpty)
                    Chip(
                      label: Text('${_selectedGenres.length} Selected'),
                      backgroundColor: Colors.deepPurple.shade100,
                    )
                ],
              ),
              const SizedBox(height: 16),

              // --- LAB 6.2: SEARCH BAR IMPLEMENTATION --- [cite: 252]
              TextField(
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value; // Cập nhật trạng thái và gọi vẽ lại UI [cite: 315]
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Type a movie title or keyword...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _searchQuery.isNotEmpty
                      ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () => setState(() => _searchQuery = ''),
                  )
                      : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                ),
              ),
              const SizedBox(height: 16),

              // --- LAB 6.2: GENRE CHIPS SECTION USING WRAP --- [cite: 252]
              const Text(
                'Genres',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              // Widget Wrap tự động xuống dòng khi màn hình bị hẹp (Responsive) [cite: 280, 324]
              Wrap(
                spacing: 8.0, // Khoảng cách ngang giữa các chip
                runSpacing: 4.0, // Khoảng cách dọc khi xuống dòng
                children: _availableGenres.map((genre) {
                  final isSelected = _selectedGenres.contains(genre);
                  return FilterChip(
                    label: Text(genre),
                    selected: isSelected,
                    onSelected: (bool selected) {
                      setState(() {
                        if (selected) {
                          _selectedGenres.add(genre); // Thêm vào bộ lọc nếu click chọn [cite: 323]
                        } else {
                          _selectedGenres.remove(genre); // Xóa khỏi bộ lọc nếu bỏ chọn [cite: 322]
                        }
                      });
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),

              // --- LAB 6.2: SORT BAR & CLEAR FILTERS DROPDOWN --- [cite: 252]
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Text('Sort by: ', style: TextStyle(fontWeight: FontWeight.w500)),
                      const SizedBox(width: 8),
                      // Điều khiển Dropdown chọn kiểu sắp xếp dữ liệu [cite: 327]
                      DropdownButton<String>(
                        value: _selectedSort,
                        items: _sortOptions.map((String option) {
                          return DropdownMenuItem<String>(
                            value: option,
                            child: Text(option),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            setState(() {
                              _selectedSort = newValue; // Cập nhật kiểu sort mới [cite: 328]
                            });
                          }
                        },
                      ),
                    ],
                  ),
                  // Phần mở rộng bonus: Nút xóa nhanh toàn bộ bộ lọc [cite: 289]
                  if (_searchQuery.isNotEmpty || _selectedGenres.isNotEmpty)
                    TextButton.icon(
                      onPressed: () {
                        setState(() {
                          _searchQuery = '';
                          _selectedGenres.clear();
                        });
                      },
                      icon: const Icon(Icons.filter_alt_off, size: 18),
                      label: const Text('Clear Filters'),
                    ),
                ],
              ),
              const SizedBox(height: 16),

              // ========================================================================
              // LAB 6.3: RESPONSIVE MOVIE LIST AREA (LAYOUTBUILDER BREAKPOINT)
              // ========================================================================
              Expanded(
                child: visibleMovies.isEmpty
                    ? const Center(child: Text('No movies match your criteria.'))
                    : LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    // Xác lập Breakpoint chuẩn kích thước chiều rộng hệ thống 800px [cite: 274, 338]
                    if (constraints.maxWidth < 800) {
                      // --- THIẾT BỊ PHONE (< 800px): Hiển thị dạng danh sách cuộn 1 cột [cite: 273, 339]
                      return ListView.builder(
                        itemCount: visibleMovies.length,
                        itemBuilder: (context, index) {
                          return _buildMovieCard(visibleMovies[index], isTablet: false);
                        },
                      );
                    } else {
                      // --- THIẾT BỊ TABLET/WEB (>= 800px): Hiển thị lưới GridView chia làm 2 cột [cite: 274, 340]
                      return GridView.builder(
                        itemCount: visibleMovies.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // Chia lưới thành 2 cột [cite: 274]
                          crossAxisSpacing: 16.0,
                          mainAxisSpacing: 16.0,
                          childAspectRatio: 2.8, // Tỷ lệ cân đối của khung Card
                        ),
                        itemBuilder: (context, index) {
                          return _buildMovieCard(visibleMovies[index], isTablet: true);
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================================
  // WIDGET COMPONENT: RENDER THẺ THÔNG TIN PHIM (MOVIE CARD) RESPONSIVE
  // ============================================================================
  Widget _buildMovieCard(Movie movie, {required bool isTablet}) {
    return Card(
      margin: isTablet ? EdgeInsets.zero : const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            // 1. Poster Ảnh phim (Sử dụng LayoutBuilder con điều chỉnh kích cỡ thích ứng) [cite: 345]
            LayoutBuilder(
              builder: (context, cardConstraints) {
                // Tùy biến kích cỡ poster cho Tablet to rộng hơn Phone [cite: 290]
                double posterWidth = isTablet ? 110 : 90;
                double posterHeight = isTablet ? 80 : 65;
                return ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    movie.posterUrl,
                    width: posterWidth,
                    height: posterHeight,
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),
            const SizedBox(width: 16),

            // 2. Khối nội dung văn bản thông tin phim
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    movie.title, // Tiêu đề phim [cite: 267, 343]
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Year: ${movie.year}', // Năm sản xuất [cite: 268, 344]
                    style: const TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  const SizedBox(height: 4),
                  // Phần mở rộng bonus: Hiển thị điểm số dạng số và màu sắc [cite: 288]
                  Row(
                    children: [
                      const Icon(Icons.star, size: 16, color: Colors.amber),
                      const SizedBox(width: 4),
                      Text(
                        '${movie.rating}/10',
                        style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}