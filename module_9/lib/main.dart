import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 9 - Local JSON Storage',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
      ),
      home: const LocalStorageScreen(),
    );
  }
}

// ============================================================================
// WIDGET ĐIỀU KHIỂN CHÍNH MÀN HÌNH LƯU TRỮ LOCAL CRUD
// ============================================================================
class LocalStorageScreen extends StatefulWidget {
  const LocalStorageScreen({super.key});

  @override
  State<LocalStorageScreen> createState() => _LocalStorageScreenState();
}

class _LocalStorageScreenState extends State<LocalStorageScreen> {
  // --- BIẾN TRẠNG THÁI (STATE VARIABLES) ---
  List<dynamic> _movies = [];       // Bộ nhớ đệm danh sách phim trong RAM
  List<dynamic> _filteredMovies = []; // Danh sách phim sau khi lọc tìm kiếm
  bool _isLoading = true;           // Trạng thái đợi tải file
  String _searchQuery = '';         // Từ khóa tìm kiếm

  @override
  void initState() {
    super.initState();
    _initLocalStorage(); // Tải dữ liệu ngay khi ứng dụng khởi chạy
  }

  // ============================================================================
  // TẦNG DỊCH VỤ FILE - READ & WRITE LOCAL STORAGE PERSISTENCE
  // ============================================================================

  // 1. Hàm tìm vị trí thư mục lưu trữ nội bộ của app trên thiết bị
  Future<File> _getLocalFile() async {
    final directory = await getApplicationDocumentsDirectory(); // Lấy thư mục Document
    return File('${directory.path}/user_movies.json'); // Trả về file đích
  }

  // 2. Logic khởi tạo, nạp và tạo file dữ liệu cục bộ ban đầu[cite: 4]
  Future<void> _initLocalStorage() async {
    try {
      final file = await _getLocalFile();

      // Kiểm tra xem file local đã tồn tại từ trước chưa (dữ liệu cũ sau khi tắt app)[cite: 4]
      if (await file.exists()) {
        // LAB 9.2: Đọc dữ liệu cũ từ bộ nhớ thiết bị[cite: 4]
        final String contents = await file.readAsString();
        setState(() {
          _movies = jsonDecode(contents); // Giải mã chuỗi JSON thành List[cite: 4]
          _filteredMovies = List.from(_movies);
          _isLoading = false;
        });
      } else {
        // LAB 9.1: Nếu chạy lần đầu tiên, tiến hành nạp file gốc từ Assets vào[cite: 4]
        final String assetsData = await rootBundle.loadString('assets/data/movies.json'); //[cite: 4]

        // Ghi bản sao này vào bộ nhớ Documents của máy để sau này sửa đổi được[cite: 4]
        await file.writeAsString(assetsData);

        setState(() {
          _movies = jsonDecode(assetsData); //[cite: 4]
          _filteredMovies = List.from(_movies);
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() => _isLoading = false);
      _showSnackBar('Error initializing local data: $e', isError: true);
    }
  }

  // 3. Hàm Auto-Save: Tự động mã hóa và ghi đè file JSON mỗi khi có thay đổi[cite: 4]
  Future<void> _saveDataToStorage() async {
    try {
      final file = await _getLocalFile();
      final String jsonString = jsonEncode(_movies); // Mã hóa List sang chuỗi JSON[cite: 4]
      await file.writeAsString(jsonString);          // Ghi đè vào bộ nhớ máy[cite: 4]
      _filterMovies(_searchQuery);                   // Làm mới danh sách hiển thị
    } catch (e) {
      _showSnackBar('Failed to save data locally.', isError: true);
    }
  }

  // ============================================================================
  // LOGIC ĐIỀU KHIỂN NGHIỆP VỤ CRUD + SEARCH BAR[cite: 4]
  // ============================================================================

  // Hàm bộ lọc tìm kiếm theo từ khóa tên phim (Lab 9.3)[cite: 4]
  void _filterMovies(String query) {
    setState(() {
      _searchQuery = query;
      if (query.isEmpty) {
        _filteredMovies = List.from(_movies);
      } else {
        _filteredMovies = _movies
            .where((movie) => movie['title'].toString().toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  // CREATE: Thêm phim mới với ID tự động tăng (Lab 9.3)[cite: 4]
  void _addMovie(String title, int year) {
    // Tìm ID lớn nhất hiện tại để cộng thêm 1, tránh trùng lặp ID (Bonus Task)[cite: 4]
    int nextId = 1;
    if (_movies.isNotEmpty) {
      nextId = _movies.map((m) => m['id'] as int).reduce((a, b) => a > b ? a : b) + 1;
    }

    final newMovie = {'id': nextId, 'title': title, 'year': year};

    setState(() {
      _movies.add(newMovie); // Đẩy vào mảng bộ nhớ tạm[cite: 4]
    });
    _saveDataToStorage(); // Tự động ghi file lưu lại ngay lập tức[cite: 4]
    _showSnackBar('Movie added successfully!'); //[cite: 4]
  }

  // UPDATE: Chỉnh sửa thông tin phim đã chọn (Lab 9.3)[cite: 4]
  void _editMovie(int id, String newTitle, int newYear) {
    setState(() {
      final index = _movies.indexWhere((m) => m['id'] == id);
      if (index != -1) {
        _movies[index]['title'] = newTitle;
        _movies[index]['year'] = newYear;
      }
    });
    _saveDataToStorage(); // Tự động lưu[cite: 4]
    _showSnackBar('Movie updated successfully!');
  }

  // DELETE: Xóa bỏ phim khỏi danh sách (Lab 9.3)[cite: 4]
  void _deleteMovie(int id) {
    setState(() {
      _movies.removeWhere((m) => m['id'] == id); // Loại bỏ khỏi RAM[cite: 4]
    });
    _saveDataToStorage(); // Tự động lưu[cite: 4]
    _showSnackBar('Movie removed successfully!');
  }

  // Thông báo SnackBar phản hồi UX nhanh (Bonus Task)[cite: 4]
  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // ============================================================================
  // TẦNG GIAO DIỆN (PRESENTATION LAYER)
  // ============================================================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('JSON Mini Database', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.amber.shade200,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator()) // Vòng xoay tải file gốc
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // --- THANH TÌM KIẾM PHIM (SEARCH BAR) ---[cite: 4]
            TextField(
              onChanged: _filterMovies, // Kích hoạt hàm lọc khi gõ chữ[cite: 4]
              decoration: InputDecoration(
                labelText: 'Search Movie...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
              ),
            ),
            const SizedBox(height: 16),

            // --- DANH SÁCH HIỂN THỊ KẾT QUẢ PHIM ---
            Expanded(
              child: _filteredMovies.isEmpty
                  ? const Center(child: Text('No movies found matching criteria.'))
                  : ListView.builder(
                itemCount: _filteredMovies.length,
                itemBuilder: (context, index) {
                  final movie = _filteredMovies[index];
                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(vertical: 6.0),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.amber.shade100,
                        child: Text('#${movie['id']}', style: const TextStyle(fontSize: 12)),
                      ),
                      // Hiển thị tối thiểu 2 trường dữ liệu bắt buộc (title, year)[cite: 4]
                      title: Text(movie['title'], style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text('Release Year: ${movie['year']}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Nút sửa thông tin[cite: 4]
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () => _openMovieFormDialog(movie: movie),
                          ),
                          // Nút xóa phần tử[cite: 4]
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _showDeleteConfirmation(movie['id']),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      // Nút bấm tròn nổi mở Form thêm phim mới[cite: 4]
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openMovieFormDialog(),
        icon: const Icon(Icons.movie),
        label: const Text('Add Movie'),
      ),
    );
  }

  // ============================================================================
  // CÁC HỘP THOẠI UX TƯƠNG TÁC (FORM DIALOGS)
  // ============================================================================

  // Hộp thoại tạo mới / Chỉnh sửa kết hợp (Add & Edit Form Dialog)[cite: 4]
  void _openMovieFormDialog({Map<String, dynamic>? movie}) {
    final isEditMode = movie != null;
    final titleController = TextEditingController(text: isEditMode ? movie['title'] : '');
    final yearController = TextEditingController(text: isEditMode ? movie['year'].toString() : '');
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isEditMode ? 'Edit Movie Data' : 'Add New Movie'), //[cite: 4]
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Movie Title', border: OutlineInputBorder()),
                validator: (v) => v == null || v.trim().isEmpty ? 'Title is required' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: yearController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Release Year', border: OutlineInputBorder()),
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Year is required';
                  if (int.tryParse(v) == null) return 'Enter a valid number';
                  return null;
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              if (!formKey.currentState!.validate()) return;

              final title = titleController.text.trim();
              final year = int.parse(yearController.text);

              if (isEditMode) {
                _editMovie(movie['id'], title, year); // Gọi hàm sửa[cite: 4]
              } else {
                _addMovie(title, year); // Gọi hàm thêm[cite: 4]
              }
              Navigator.pop(context); // Đóng hộp thoại
            },
            child: Text(isEditMode ? 'Save Changes' : 'Submit'),
          ),
        ],
      ),
    );
  }

  // Hộp thoại xác nhận trước khi xóa (Confirm Dialog - Bonus Task)[cite: 4]
  void _showDeleteConfirmation(int id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.warning, color: Colors.red),
            SizedBox(width: 8),
            Text('Confirm Delete'),
          ],
        ),
        content: const Text('Are you sure you want to completely remove this movie out of database?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
            onPressed: () {
              _deleteMovie(id); // Gọi hàm xóa thực sự[cite: 4]
              Navigator.pop(context);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}