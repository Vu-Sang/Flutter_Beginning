import 'dart:async';

Future<void> runExercise4() async {
  print("\n--- Exercise 4: Stream Transformation ---");

  // Khởi tạo luồng số từ 1 đến 5
  Stream<int> originNumberStream = Stream<int>.fromIterable([1, 2, 3, 4, 5]);

  // Biến đổi: Bình phương (map) rồi Lọc số chẵn (where)
  Stream<int> transformedStream = originNumberStream
      .map((number) => number * number)
      .where((square) => square % 2 == 0);

  print("   Listening to transformed stream (Expected: Even Squares)...");
  await for (var value in transformedStream) {
    print("   -> Emitted Stream Value: $value");
  }
}