import 'dart:async';

Future<void> runExercise3() async {
  print("\n--- Exercise 3: Async + Microtask Debugging ---");

  print("   [1] Main Synchronous Code - START");

  // Đưa tác vụ vào Event Queue
  Future(() {
    print("   [4] Event Queue Callback (Future task executed)");
  });

  // Đưa tác vụ vào Microtask Queue (Được ưu tiên cao hơn)
  scheduleMicrotask(() {
    print("   [3] Microtask Queue Callback (scheduleMicrotask executed)");
  });

  print("   [2] Main Synchronous Code - END");

  await Future.delayed(const Duration(milliseconds: 200));
}