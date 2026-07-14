import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  // Thực hiện yêu cầu POST xác thực tài khoản thực từ DummyJSON API
  Future<String?> loginWithApi(String username, String password) async {
    final url = Uri.parse('https://dummyjson.com/auth/login');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username, // Sử dụng tài khoản mẫu của DummyJSON ví dụ: emilys
          'password': password, // Mật khẩu mẫu: emilyspass
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['accessToken'] as String; // Trích xuất mã Token từ API
      } else {
        final errorMsg = jsonDecode(response.body)['message'] ?? 'Login failed';
        throw Exception(errorMsg);
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
}