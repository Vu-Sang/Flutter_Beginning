# BÁO CÁO THU HOẠCH: MODULE 3 – ADVANCED DART PROGRAMMING & ARCHITECTURE

## 1. Đề Bài Yêu Cầu Gì? (Lab 3 Requirements)
Hoàn thành 5 mini-project kiểm thử các tính năng nâng cao của Dart:
* **Exercise 1 (Product Model & Repository):** Xây dựng model Product và tạo kho chứa dữ liệu (Repository) hỗ trợ cả hành vi `Future` lẫn luồng cập nhật thời gian thực bằng `StreamController.broadcast()`.
* **Exercise 2 (User Repository with JSON):** Tạo model User tích hợp factory constructor `User.fromJson` để giải mã (parse) một chuỗi dữ liệu JSON thô mô phỏng nhận về từ API.
* **Exercise 3 (Async + Microtask Debugging):** Viết đoạn code chứa `scheduleMicrotask()` và `Future()` để in và giải thích chính xác thứ tự thực thi của Event Loop.
* **Exercise 4 (Stream Transformation):** Khởi tạo một stream số nguyên, áp dụng các hàm chức năng nâng cao gồm `.map()` (bình phương) và `.where()` (lọc số chẵn) rồi lắng nghe kết quả.
* **Exercise 5 (Factory Constructors & Cache):** Tạo lớp `Settings` dùng Private Constructor và Factory Constructor để thiết lập bộ nhớ đệm cache, kiểm tra tính độc nhất bằng hàm `identical()` nhằm chứng minh mẫu thiết kế Singleton.

## 2. Các Kiến Thức Cốt Lõi Cần Nắm Chắc (Core Knowledge)
* **Broadcast Stream:** Ứng dụng `StreamController.broadcast()` để luồng dữ liệu hỗ trợ nhiều bên cùng đăng ký lắng nghe sự kiện đồng thời (Multi-subscription).
* **JSON Serialization & Deserialization:** Cách sử dụng `jsonDecode()` kết hợp với **Factory Constructor** để tự động chuyển đổi từ dữ liệu map thô sang đối tượng Object có cấu trúc rõ ràng.
* **Dart Event Loop & Queues:** Cơ chế vận hành của hai hàng đợi bất đồng bộ: `Microtask Queue` (luôn được ưu tiên xử lý trước tuyệt đối) và `Event Queue` (xử lý các sự kiện thông thường sau khi luồng đồng bộ và microtask trống).
* **Stream Functional Operators:** Làm chủ kỹ thuật lập trình hàm xử lý luồng bằng `.map()` và `.where()`.
* **Mẫu thiết kế Singleton:** Kỹ thuật ẩn hàm khởi tạo và dùng từ khóa `factory` để kiểm soát vùng nhớ và tái sử dụng thực thể duy nhất nhằm tối ưu hóa RAM hệ thống.

## 3. Sau Khi Làm Xong Được Gì? (Key Skills)
* Sở hữu tư duy lập trình nâng cao, sẵn sàng tương tác dữ liệu bất đồng bộ mô phỏng các kết nối gọi API hệ thống từ Server.
* Có năng lực tổ chức dự án chuyên nghiệp theo **Kiến trúc phân tầng (Layered Architecture)** bằng cách phân tách độc lập các thư mục chức năng (`models/`, `repositories/`, `exercises/`), giúp mã nguồn sạch sẽ và dễ bảo trì.
* Nắm giữ nền tảng kiến thức vững chắc về luồng dữ liệu để làm việc với các thư viện quản lý trạng thái nâng cao của Flutter như BLoC, Riverpod hoặc bộ xây dựng giao diện tự động `StreamBuilder`.