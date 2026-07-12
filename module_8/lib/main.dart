import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 8 - API Integration',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      home: const PostListScreen(),
    );
  }
}

// ============================================================================
// LAB 8.2: TẦNG DỮ LIỆU - DART MODEL CLASS
// ============================================================================
class Post {
  final int id;
  final int userId;
  final String title;
  final String body;

  const Post({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
  });

  // Factory Method giải mã JSON sang đối tượng Dart Model
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] as int,
      userId: json['userId'] as int,
      title: json['title'] as String,
      body: json['body'] as String,
    );
  }
}

// ============================================================================
// LAB 8.4: TẦNG DỊCH VỤ - API SERVICE CLASS (SERVICE LAYER PATTERN)
// ============================================================================
class ApiService {
  final http.Client client;
  final String baseUrl = 'https://jsonplaceholder.typicode.com/posts'; // Endpoint mẫu tĩnh

  ApiService({http.Client? client}) : client = client ?? http.Client();

  // 1. Thực hiện phương thức GET lấy danh sách bài viết từ REST API
  Future<List<Post>> fetchPosts() async {
    try {
      final response = await client.get(Uri.parse(baseUrl)).timeout(
        const Duration(seconds: 10), // Cấu hình timeout bảo vệ ứng dụng
      );

      if (response.statusCode == 200) {
        // Chuyển đổi chuỗi String nhận về thành danh sách động bằng json.decode()
        final List<dynamic> decodedList = json.decode(response.body);

        // Map danh sách thô sang List<Post> thông qua Factory Method[cite: 4]
        return decodedList.map((item) => Post.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load posts (Status Code: ${response.statusCode})');
      }
    } catch (e) {
      // Đẩy lỗi ra ngoài cho khối FutureBuilder xử lý[cite: 4]
      throw Exception('Network error or server timeout. Please check your connection.');
    }
  }

  // 2. Tùy chọn nâng cao: Thực hiện phương thức POST gửi bài viết mới lên Server[cite: 4]
  Future<Post> createPost(String title, String body) async {
    try {
      final response = await client.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode({
          'title': title,
          'body': body,
          'userId': 1, // Fix cứng ID người dùng mô phỏng
        }),
      );

      if (response.statusCode == 201) {
        // Trạng thái 201: Khởi tạo dữ liệu thành công[cite: 4]
        return Post.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to create post (Status Code: ${response.statusCode})');
      }
    } catch (e) {
      throw Exception('Failed to send data to the server.');
    }
  }
}

// ============================================================================
// TẦNG GIAO DIỆN CHÍNH - DISPLAY API DATA WITH FUTUREBUILDER[cite: 4]
// ============================================================================
class PostListScreen extends StatefulWidget {
  const PostListScreen({super.key});

  @override
  State<PostListScreen> createState() => _PostListScreenState();
}

class _PostListScreenState extends State<PostListScreen> {
  final ApiService _apiService = ApiService();
  late Future<List<Post>> _postsFuture;

  @override
  void initState() {
    super.initState();
    _loadData(); // Khởi chạy nạp dữ liệu lần đầu tiên
  }

  void _loadData() {
    setState(() {
      _postsFuture = _apiService.fetchPosts(); // Gán luồng bất đồng bộ vào biến tương lai[cite: 4]
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('REST API Explorer', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.indigo.shade100,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadData, // Nút làm mới nhanh dữ liệu[cite: 4]
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async => _loadData(), // Kéo để làm mới dữ liệu (Bonus Task)[cite: 4]
        child: FutureBuilder<List<Post>>(
          future: _postsFuture,
          builder: (context, snapshot) {
            // TRẠNG THÁI 1: HỆ THỐNG ĐANG ĐỢI TẢI DỮ LIỆU (LOADING STATE)[cite: 4]
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(), //[cite: 4]
                    SizedBox(height: 16),
                    Text('Fetching data from API, please wait...', style: TextStyle(color: Colors.grey)),
                  ],
                ),
              );
            }

            // TRẠNG THÁI 2: HỆ THỐNG GẶP LỖI MẠNG/SERVER (ERROR STATE)[cite: 4]
            if (snapshot.hasError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.cloud_off, size: 64, color: Colors.red),
                      const SizedBox(height: 16),
                      const Text(
                        'Oops! Something went wrong', // Thông báo lỗi thân thiện[cite: 4]
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${snapshot.error}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton.icon(
                        onPressed: _loadData, // Nút ấn thử lại (Bonus Task)[cite: 4]
                        icon: const Icon(Icons.replay),
                        label: const Text('Retry Again'),
                      ),
                    ],
                  ),
                ),
              );
            }

            // TRẠNG THÁI 3: DỮ LIỆU TRẢ VỀ THÀNH CÔNG (SUCCESS DATA STATE)[cite: 4]
            if (snapshot.hasData) {
              final posts = snapshot.data!;
              if (posts.isEmpty) {
                return const Center(child: Text('No posts found.'));
              }

              return ListView.builder(
                padding: const EdgeInsets.all(8.0),
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  final post = posts[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 4.0),
                    elevation: 1.5,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.indigo.shade50,
                        child: Text('#${post.id}', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                      ),
                      title: Text(
                        post.title, // Hiển thị 1-2 trường (Tiêu đề phim/bài viết)[cite: 4]
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(
                        post.body,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
                      onTap: () {
                        // Xem chi tiết bài viết (Bonus Task)[cite: 4]
                        _showDetailDialog(context, post);
                      },
                    ),
                  );
                },
              );
            }

            return const Center(child: Text('No states detected.'));
          },
        ),
      ),
      // Nút bấm nổi mở Form gửi dữ liệu POST (Lab 7 -> Lab 8 workflow)[cite: 4]
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showCreatePostBottomSheet(context),
        icon: const Icon(Icons.add),
        label: const Text('New Post'),
      ),
    );
  }

  // ============================================================================
  // CÁC HỘP THOẠI BỔ TRỢ TRẢI NGHIỆM NGƯỜI DÙNG (UX BONUS)[cite: 4]
  // ============================================================================

  // Hộp thoại xem chi tiết phần tử[cite: 4]
  void _showDetailDialog(BuildContext context, Post post) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(post.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        content: SingleChildScrollView(child: Text(post.body)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close')),
        ],
      ),
    );
  }

  // Cửa sổ BottomSheet nhập liệu Form để gọi POST Request[cite: 4]
  void _showCreatePostBottomSheet(BuildContext context) {
    final titleController = TextEditingController();
    final bodyController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    bool isSubmitting = false;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16, right: 16, top: 16,
          ),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text('Create New Post (POST API)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                TextFormField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: 'Title', border: OutlineInputBorder()),
                  validator: (v) => v == null || v.isEmpty ? 'Title is required' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: bodyController,
                  maxLines: 3,
                  decoration: const InputDecoration(labelText: 'Body Content', border: OutlineInputBorder()),
                  validator: (v) => v == null || v.isEmpty ? 'Body content is required' : null,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: isSubmitting ? null : () async {
                    if (!formKey.currentState!.validate()) return;

                    setModalState(() => isSubmitting = true);
                    try {
                      final newPost = await _apiService.createPost(titleController.text, bodyController.text);
                      if (!context.mounted) return;
                      Navigator.pop(context); // Tắt form nhập liệu

                      // Hiển thị thông báo phản hồi kết quả thành công[cite: 4]
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Post created successfully! (ID Assigned: ${newPost.id})'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    } catch (e) {
                      setModalState(() => isSubmitting = false);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('$e'), backgroundColor: Colors.red),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo, foregroundColor: Colors.white),
                  child: isSubmitting
                      ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                      : const Text('Submit Post'),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}