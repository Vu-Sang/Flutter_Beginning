import '../models/product.dart';
import '../repositories/product_repository.dart';

Future<void> runExercise1(ProductRepository repo) async {
  print("--- Exercise 1: Product Model & Repository ---");

  // Đăng ký bộ lắng nghe sự kiện Stream live cập nhật thời gian thực
  repo.liveAdded.listen((product) {
    print("   [Live Stream Webhook]: New Item Added -> $product");
  });

  print("   Fetching static product list from repository...");
  List<Product> staticProducts = await repo.getAll();
  print("   Static Data: $staticProducts");

  // Kích hoạt đẩy dữ liệu live
  repo.addProductLive(Product(id: 3, name: "MacBook Pro M4", price: 2000.0));
  repo.addProductLive(Product(id: 4, name: "Sony WH-1000XM5", price: 350.0));

  await Future.delayed(const Duration(milliseconds: 100)); // Chờ stream in xong
}