import 'dart:async';

// ============================================================================
// EXERCISE 4: INTRO TO OOP (Định nghĩa các Class ngoài hàm main)
// ============================================================================
class Car {
  String brand;

  // Default Constructor
  Car(this.brand);

  // Named Constructor
  Car.anonymous() : brand = "Unknown Brand";

  void displayInfo() {
    print("Car Brand: $brand");
  }
}

// SubClass
class ElectricCar extends Car {
  double batteryCapacity; // Thuộc tính riêng của xe điện (Dung lượng pin)

  // Constructor của lớp con, gọi constructor của lớp cha bằng 'super'
  ElectricCar(String brand, this.batteryCapacity) : super(brand);

  // Ghi đè phương thức (Method Overriding) bằng @override để thay đổi hành vi [cite: 349, 858]
  @override
  void displayInfo() {
    print("Electric Car Brand: $brand | Battery: $batteryCapacity kWh");
  }
}

// ============================================================================
// EXERCISE 5: ASYNC & FUNCTION HELPER
// ============================================================================

Future<String> fetchNetworkData() async {
  // Sử dụng Future.delayed() để giả lập thời gian chờ (Latency) 2 giây [cite: 864]
  await Future.delayed(Duration(seconds: 2));
  return "Successfully loaded secure database connection!";
}

// Hàm sinh luồng dữ liệu (Stream Generator) sử dụng async* và yield [cite: 698, 699, 866]
Stream<int> countSecondsStream() async* {
  for (int i = 1; i <= 3; i++) {
    await Future.delayed(Duration(seconds: 1)); // Đợi 1 giây giữa mỗi lần phát
    yield i; // Kích hoạt phát giá trị ra ngoài luồng (emit value) [cite: 386, 700]
  }
}

// ============================================================================
// MAIN ENTRY POINT
// ============================================================================
void main() async {
  print("=== FPT UNIVERSITY - PRM393 LAB 2 REPORT ===");

  // --------------------------------------------------------------------------
  // EXERCISE 1 – Basic Syntax & Data Types
  // --------------------------------------------------------------------------
  print("\n--- Exercise 1: Basic Syntax & Data Types ---");

  int studentId = 12345;               // Số nguyên
  double currentGpa = 3.85;            // Số thực
  String studentName = "Vu Dinh Sang"; // Chuỗi văn bản
  bool isEnrolled = true;              // Boolean value

  // Sử dụng String Interpolation ($var và ${expr}) để nhúng giá trị vào chuỗi
  print("Student Name: $studentName");
  print("ID: SE$studentId | Status Active: $isEnrolled");
  print("Current GPA $currentGpa");
  print("Next Target GPA: ${currentGpa + 0.15}");

  // --------------------------------------------------------------------------
  // EXERCISE 2 – Collections & Operators=
  // --------------------------------------------------------------------------
  print("\n--- Exercise 2: Collections & Operators ---");

  // 1.
  List<int> scoreList = [8, 9, 6, 8, 7];
  print("List beginning : $scoreList");
  scoreList.add(10);
  print("List scores after adding 10: $scoreList");

  // 2. Sử dụng các toán tử số học (Arithmetic) & so sánh (Comparison)
  int firstScore = scoreList[0];
  int totalOfTwo = firstScore + scoreList[1];
  bool isHigherThanEight = firstScore >= 8;
  print("Total of first two elements: $totalOfTwo");
  print("Is the first score >= 8? Answer: $isHigherThanEight");

  // 3. Tạo một Set
  Set<String> uniqueTags = {"Flutter", "Dart", "Flutter"}; // "Flutter" bị trùng sẽ bị loại bỏ
  uniqueTags.add("Mobile"); // Sử dụng hàm add()
  print("Unique Set elements (no duplicates): $uniqueTags");

  // 4. Tạo một Map (Cấu trúc Key-Value lưu trữ cặp Khóa - Giá trị)
  Map<String, dynamic> projectMeta = {
    "title": "PetEye Marketplace",
    "version": 1.0,
    "isBeta": false
  };
  print("Project Title (Map Access): ${projectMeta["title"]}"); // Truy cập qua key

  // 5. Sử dụng toán tử điều kiện Ternary Operator (? :)
  String appStatus = projectMeta["isBeta"] == true ? "Testing Phase" : "Production Ready";
  print("Application Status: $appStatus");

  // --------------------------------------------------------------------------
  // EXERCISE 3 – Control Flow & Functions
  // --------------------------------------------------------------------------
  print("\n--- Exercise 3: Control Flow & Functions ---");

  int examScore = 85;
  // Khối lệnh if/else kiểm tra xếp loại điểm
  if (examScore >= 90) {
    print("Grade: Excellent");
  } else if (examScore >= 50) {
    print("Grade: Pass"); // Logic thỏa mãn điều kiện này
  } else {
    print("Grade: Fail");
  }

  // Cấu trúc rẽ nhánh Switch Case
  String currentDay = "Wednesday";
  switch (currentDay) {
    case "Monday":
      print("Status: Start of the week.");
      break;
    case "Wednesday":
      print("Status: Mid-week working hard."); // Trùng khớp logic tại đây
      break;
    default:
      print("Status: Weekend is coming.");
  }

  // Duyệt và lặp qua Collection bằng 3 kỹ thuật loop khác nhau
  List<String> frameworkList = ["Spring Boot", "React", "Flutter"];

  // Kiểu 1: Vòng lặp Counted For Loop truyền thống
  print("1. Classic for-loop:");
  for (int i = 0; i < frameworkList.length; i++) {
    print("   Index $i: ${frameworkList[i]}");
  }

  // Kiểu 2: Vòng lặp For-in lướt qua mọi phần tử
  print("2. For-in loop:");
  for (var tech in frameworkList) {
    print("   Tech item: $tech");
  }

  // Kiểu 3: Kỹ thuật lập trình hàm Style Functional với forEach()
  print("3. forEach style:");
  frameworkList.forEach((tech) => print("   Functional element: $tech"));

  // Khai báo và sử dụng hàm Normal Syntax và Arrow Syntax (Hàm rút gọn)
  // Hàm Normal với thân hàm ngoặc nhọn đầy đủ
  int computeSquareNormal(int number) {
    return number * number;
  }

  // Hàm Arrow Syntax tối ưu dòng code cho biểu thức đơn
  int computeSquareArrow(int number) => number * number;

  print("Square via Normal function: ${computeSquareNormal(5)}");
  print("Square via Arrow function: ${computeSquareArrow(5)}");

  // --------------------------------------------------------------------------
  // EXERCISE 4 – Intro to OOP
  // --------------------------------------------------------------------------
  print("\n--- Exercise 4: Intro to OOP ---");

  // Khởi tạo đối tượng từ lớp cha sử dụng Constructor mặc định
  Car standardCar = Car("Toyota Corolla");
  standardCar.displayInfo(); // Output kết quả ra console

  // Khởi tạo đối tượng thông qua Named Constructor đã định nghĩa
  Car mysteriousCar = Car.anonymous();
  mysteriousCar.displayInfo();

  // Khởi tạo đối tượng lớp con (Kế thừa và Ghi đè phương thức hiển thị)
  ElectricCar teslaVehicle = ElectricCar("Tesla Model Y", 75.0);
  teslaVehicle.displayInfo(); // Sẽ in ra định dạng riêng của xe điện nhờ @override

  // --------------------------------------------------------------------------
  // EXERCISE 5 – Async, Future, Null Safety & Streams [cite: 860]
  // --------------------------------------------------------------------------
  print("\n--- Exercise 5: Async, Future, Null Safety & Streams ---");

  // 1. Thực thi Hàm Async/Await lấy kết quả trả về từ Future
  print("Executing secure background process task...");
  String networkResponse = await fetchNetworkData(); // Hàm sẽ tạm dừng tại đây chờ kết quả mà không đơ UI
  print("Response received: $networkResponse"); // Chạy sau khi hết 2 giây trì hoãn

  // 2. Thực hành với các toán tử an toàn Null (Null-safety operators) [
  String? nullableBio; // Biến này cho phép mang giá trị null nhờ dấu ?
  nullableBio = null;  // Gán thử nghiệm null

  // Toán tử ?? (Null-coalescing): Trả về giá trị mặc định nếu vế trước bị null
  print("User Bio Output: ${nullableBio ?? "Biographical information is empty"}");

  nullableBio = "Active developer at FPT University Portfolio";
  // Toán tử ! (Force non-null assertion): Ép buộc hệ thống hiểu biến chắc chắn có dữ liệu
  print("Bio String length safely fetched: ${nullableBio!.length}");

  // 3. Khởi tạo một Luồng dữ liệu (Stream) và thực hiện lắng nghe (Listen) sự kiện
  print("Starting Stream simulation listener (Emits every 1 second):");
  Stream<int> secondsStream = countSecondsStream();

  // Đăng ký bộ lắng nghe sự kiện (Listen to emitted stream values)
  await for (var second in secondsStream) {
    print("   Stream Tick: Emitted Second $second"); // Tự động in kết quả tuần tự theo thời gian
  }
  print("Stream operation completed successfully.");
}