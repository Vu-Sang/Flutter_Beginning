

import 'package:module_3/repositories/product_repository.dart';

import 'exercises/exercise1.dart';
import 'exercises/exercise2.dart';
import 'exercises/exercise3.dart';
import 'exercises/exercise4.dart';
import 'exercises/exercise5.dart';

void main() async {
  print("====================================================");
  print("    FPT UNIVERSITY - PRM393 ARCHITECTURE LAB 3    ");
  print("====================================================\n");

  final productRepo = ProductRepository();

  // Chạy tuần tự các tầng bài tập đã được tách biệt
  await runExercise1(productRepo);
  await runExercise2();
  await runExercise3();
  await runExercise4();
  runExercise5();

  // Giải phóng tài nguyên hệ thống
  productRepo.dispose();
  print("\n================== LAB COMPLETED ==================");
}