import 'dart:async';
import 'dart:convert';
import '../models/user.dart';

class UserRepository {
  // Giả lập chuỗi JSON thô nhận từ Server API
  final String _rawApiResponse =
      '[{"name": "Vu Dinh Sang", "email": "sangvdse180455@fpt.edu.vn"}, {"name": "Nguyen Ngoc Nhu", "email": "nhungoc@fpt.edu.vn"}]';

  // Hàm gọi dữ liệu bất đồng bộ và tự động phân rã JSON
  Future<List<User>> fetchAndParseUsers() async {
    await Future.delayed(const Duration(milliseconds: 500)); // Delay mạng

    // Giải mã chuỗi chuỗi String sang List dữ liệu động
    final List<dynamic> decodedJson = jsonDecode(_rawApiResponse) as List<dynamic>;

    // Map từng phần tử JSON sang Object User thông qua factory constructor
    return decodedJson.map((item) => User.fromJson(item as Map<String, dynamic>)).toList();
  }
}