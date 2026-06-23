import 'dart:async';
import '../models/product.dart';

class ProductRepository {
  // Sử dụng StreamController.broadcast() cho cơ chế live update dữ liệu thực tế
  final StreamController<Product> _liveAddedController = StreamController<Product>.broadcast();

  // Giả lập lấy danh sách sản phẩm tĩnh (API/DB delay 1 giây)
  Future<List<Product>> getAll() async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      Product(id: 1, name: "Lenovo Legion 5", price: 1200.0),
      Product(id: 2, name: "iPhone 16 Pro Max", price: 1500.0),
    ];
  }

  // Getter cung cấp luồng Stream ra bên ngoài lắng nghe
  Stream<Product> get liveAdded => _liveAddedController.stream;

  // Hàm thêm sản phẩm live thời gian thực
  void addProductLive(Product product) {
    _liveAddedController.add(product);
  }

  // Đóng Stream khi giải phóng vùng nhớ
  void dispose() {
    _liveAddedController.close();
  }
}