import '../models/user.dart';
import '../repositories/user_repository.dart';

Future<void> runExercise2() async {
  print("\n--- Exercise 2: User Repository with JSON ---");
  final userRepo = UserRepository();

  print("   Simulating API Request to fetch users...");
  List<User> userList = await userRepo.fetchAndParseUsers();
  print("   Parsed Users Output successfully:");
  for (var user in userList) {
    print("   -> $user");
  }
}