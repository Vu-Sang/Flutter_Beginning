# BÁO CÁO THU HOẠCH: MODULE 2 – DART ESSENTIALS FUNDAMENTALS

## 1. Đề Bài Yêu Cầu Gì? (Lab 2 Requirements)
Hoàn thành 5 bài tập thực hành cốt lõi của ngôn ngữ Dart chạy trực tiếp trên Console (DartPad/Android Studio):
* **Exercise 1 (Basic Syntax):** Khai báo và sử dụng các kiểu dữ liệu cơ bản, hiển thị giá trị ra console bằng String Interpolation.
* **Exercise 2 (Collections & Operators):** Thao tác thêm/xóa phần tử trên List, Set, Map; áp dụng các toán tử số học, so sánh và toán tử điều kiện Ternary.
* **Exercise 3 (Control Flow & Functions):** Viết logic phân loại điểm bằng `if/else`, cấu trúc rẽ nhánh `switch-case`, duyệt danh sách bằng 3 kiểu vòng lặp (`for`, `for-in`, `forEach`) và viết hàm dạng thường kết hợp hàm rút gọn Arrow syntax.
* **Exercise 4 (Intro to OOP):** Định nghĩa class `Car`, viết Default Constructor và Named Constructor; tạo subclass `ElectricCar` kế thừa và thực hiện ghi đè phương thức bằng `@override`.
* **Exercise 5 (Async & Null Safety):** Viết hàm bất đồng bộ sử dụng `Future` + `await`, làm quen các toán tử Null-safety (`?`, `??`, `!`) và tạo một `Stream` số nguyên đơn giản.

## 2. Các Kiến Thức Cốt Lõi Cần Nắm Chắc (Core Knowledge)
* **Khai báo biến & Core Types:** Thành thạo kiểu dữ liệu tĩnh `int`, `double`, `String`, `bool` và kỹ thuật nhúng biểu thức qua **String Interpolation** (`$var`, `${expr}`).
* **Bản chất của Collections:** Phân biệt `List` (danh sách có thứ tự), `Set` (tập hợp phần tử duy nhất) và `Map` (cấu trúc cặp Key-Value).
* **Cú pháp hàm nâng cao:** Sử dụng linh hoạt giữa **Normal Syntax** (Thân hàm ngoặc nhọn đầy đủ) và **Arrow Syntax** (`=>` - Hàm mũi tên rút gọn cho biểu thức đơn).
* **Hướng đối tượng cơ bản (OOP):** Cơ chế kế thừa (`extends`) và đa hình thông qua Ghi đè phương thức (`@override`).
* **Cơ chế Null Safety & Async cơ bản:** Cách dùng các toán tử an toàn dữ liệu rỗng và sự phối hợp giữa `async`/`await` để xử lý các tác vụ bất đồng bộ không gây nghẽn luồng chạy chính.

## 3. Sau Khi Làm Xong Được Gì? (Key Skills)
* Xây dựng và thực thi thuần thục các đoạn mã kiểm thử thuật toán dòng lệnh (Console Application) bằng ngôn ngữ Dart.
* Làm chủ tư duy lập trình hướng đối tượng (OOP) để làm tiền đề thiết kế cấu trúc UI Component trong Flutter.
* Kiểm soát chặt chẽ dữ liệu và bảo vệ ứng dụng khỏi lỗi sập app kinh điển liên quan đến giá trị rỗng (`NullPointerException`).