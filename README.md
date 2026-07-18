# 📱 FLUTTER MOBILE DEVELOPMENT — COMPLETE LAB SUITE SUMMARY

Tài liệu này tổng hợp toàn bộ lộ trình và cấu trúc phát triển qua 12 bài Lab thực hành, từ những khái niệm cơ bản về lập trình giao diện (UI) cho đến các kỹ năng nâng cao như kết nối REST API, quản lý trạng thái, bảo mật hệ thống và tối ưu hóa hiệu năng ứng dụng di động.

---

## 🗺️ TỔNG QUAN LỘ TRÌNH 12 BÀI LAB

### 📑 HỌC PHẦN 1: NỀN TẢNG UI & ĐIỀU HƯỚNG MÀN HÌNH
* **Lab 1 -> Lab 6:** Làm quen với Dart Core, xây dựng bố cục giao diện với các Widget cơ bản (`Container`, `Column`, `Row`, `ListView`), xử lý sự kiện người dùng và thiết lập luồng điều hướng màn hình (`Navigator.push`, `Navigator.pop`).
* **Lab 7 – State Management:** Chuyển dịch tư duy từ UI tĩnh sang UI động. Làm quen với các giải pháp quản lý trạng thái ứng dụng (`setState`, `ChangeNotifierProvider`, hoặc `Bloc`) để đồng bộ dữ liệu trên toàn hệ thống.

---

### 🌐 HỌC PHẦN 2: KẾT NỐI MẠNG & DỮ LIỆU CỤC BỘ
### 🔹 Lab 8 – REST API Integration (Kiến trúc Phân tầng)
* **Mục tiêu:** Kết nối ứng dụng với môi trường Internet thông qua giao thức HTTP.
* **Kỹ thuật cốt lõi:** 
  * Sử dụng gói thư viện `http` để thực thi các yêu cầu bất đồng bộ (`Future`, `async/await`).
  * Triển khai kiến trúc **Service Layer Pattern** để cô lập hoàn toàn logic kết nối mạng khỏi lớp giao diện hiển thị.
  * Ánh xạ chuỗi dữ liệu thô từ Server (`json.decode`) thành các đối tượng dữ liệu an toàn trong mã nguồn nhờ hàm factory `fromJson()`.
  * Quản lý trạng thái vòng đời kết nối (Đang tải, Lỗi mạng, Thành công) trực quan qua `FutureBuilder`.

### 🔹 Lab 9 – Local JSON Storage (Lưu trữ tệp cục bộ)
* **Mục tiêu:** Xây dựng cơ sở dữ liệu thu nhỏ (Mini Database) ngay trên bộ nhớ thiết bị nhằm bảo toàn dữ liệu khi ứng dụng khởi động lại (Local Persistence)[cite: 4].
* **Kỹ thuật cốt lõi:**
  * Khởi tạo dữ liệu gốc từ tài nguyên nhúng ứng dụng (`rootBundle.loadString`)[cite: 4].
  * Sử dụng thư viện `path_provider` để định vị phân vùng ổ cứng an toàn của ứng dụng (`getApplicationDocumentsDirectory`)[cite: 4].
  * Thực hiện mã hóa (`jsonEncode`) và giải mã (`jsonDecode`) cấu trúc mảng động để triển khai trọn vẹn 4 nghiệp vụ dữ liệu **CRUD** (Thêm, Đọc, Sửa, Xóa) tự động lưu xuống file tệp tin[cite: 4].

---

### 🔐 HỌC PHẦN 3: BẢO MẬT HỆ THỐNG & TƯƠNG TÁC NÂNG CAO
### 🔹 Lab 10 – Authentication, Session Management & Notifications
* **Mục tiêu:** Thiết lập cổng bảo mật xác thực tài khoản và hệ thống nhắc nhở người dùng.
* **Kỹ thuật cốt lõi:**
  * Xây dựng biểu mẫu đăng nhập (Login Form Validation) kết nối trực tiếp với cổng API thực tế (DummyJSON API).
  * Quản lý phiên làm việc vĩnh viễn với mã Token thông qua bộ nhớ đệm `SharedPreferences`, thiết lập cơ chế tự động chuyển vùng màn hình khi mở app (Auto-login & Splash Routing).
  * Triển khai giải pháp thông báo đẩy cục bộ (`flutter_local_notifications`), xin quyền hệ điều hành (Android 13+) và kích hoạt thông báo real-time sau các hành vi cốt lõi (Đăng nhập/Đăng xuất thành công).

---

### 🧪 HỌC PHẦN 4: KIỂM THỬ, TỐI ƯU HÓA & ĐÓNG GÓI SẢN PHẨM
### 🔹 Lab 11 – Testing & Debugging (Taskly App)
* **Mục tiêu:** Viết các kịch bản kiểm thử tự động để đảm bảo tính ổn định tối đa của mã nguồn và giao diện ứng dụng.
* **Kỹ thuật cốt lõi:**
  * **Unit Testing:** Kiểm thử đơn vị cô lập trên các hàm Dart thuần (Task Model & TaskRepository) áp dụng quy chuẩn mẫu AAA (Arrange -> Act -> Assert).
  * **Widget Testing:** Kiểm thử thành phần giao diện thực tế thông qua các hàm giả lập hành vi gõ chữ, chạm nút (`pumpWidget`, `enterText`, `tap`).
  * **Navigation & Integration Testing:** Kiểm thử luồng điều hướng màn hình và giả lập chuỗi hành vi tương tác khép kín từ đầu đến cuối (End-to-End flow).
  * Sử dụng **Flutter DevTools** (Widget Inspector, Performance Timeline) để phân tích cây Widget và phát hiện sớm các vùng nghẽn FPS.

### 🔹 Lab 12 – Performance Optimization & App Deployment
* **Mục tiêu:** Tối ưu hóa triệt để tài nguyên hệ thống và phát hành tệp tin cài đặt thương mại thương mại.
* **Kỹ thuật cốt lõi:**
  * **Tối ưu hóa List Rebuilds:** Thay thế `setState` toàn cục bằng `Selector<Provider>`, phân rã các Widget inline thành lớp con độc lập (`TaskTile`) kết hợp định danh `ValueKey(id)` để giảm 80% tần suất tái dựng UI không cần thiết.
  * **Asset Optimization:** Tiến hành nén và định lại kích thước hình ảnh tài nguyên về chuẩn di động (128x128 px), sử dụng cơ chế nạp trước hình ảnh (`precacheImage`) vào RAM.
  * **App Size Analysis:** Chạy các lệnh kiểm soát dung lượng chuyên sâu (`flutter build apk --analyze-size`) để bóc tách các thành phần chiếm dụng bộ nhớ ổ cứng.
  * **Deployment:** Chạy kiểm thử môi trường cận thực tế (`--profile mode`), dọn dẹp hệ thống (`flutter clean`) và xuất bản gói cài đặt thương mại chính thức thành công (`flutter build apk --release` hoặc `.aab`).

---

## 🛠️ CÔNG CỤ & THƯ VIỆN ĐÃ SỬ DỤNG LỚN (CORE DEPENDENCIES)
* **Môi trường:** Flutter SDK (Stable), Android Studio / VS Code, DartPad.
* **Thư viện bên thứ ba:**
  * `http` (Kết nối REST API)
  * `path_provider` (Truy cập tệp hệ thống)[cite: 4]
  * `shared_preferences` (Lưu giữ bộ nhớ đệm key-value)
  * `provider` (Quản lý trạng thái ứng dụng & Tối ưu Rebuilds)
  * `flutter_local_notifications` (Kênh thông báo đẩy hệ điều hành)
