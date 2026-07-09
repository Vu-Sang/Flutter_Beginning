# BÁO CÁO THU HOẠCH: MODULE 1 – FLUTTER INTRODUCTION & ENVIRONMENT SETUP

## 1. Đề Bài Yêu Cầu Gì? (Lab 1 Requirements)
* **Thiết lập môi trường:** Cài đặt thành công Flutter SDK, Android Studio/VS Code và cấu hình biến môi trường.
* **Chẩn đoán hệ thống:** Chạy lệnh `flutter doctor` trong Terminal để kiểm tra và khắc phục toàn bộ các lỗi cấu hình (Android Toolchain, Cài đặt trình duyệt, Licenses).
* **Khởi tạo và chạy ứng dụng:** Tạo một dự án Flutter mới, khởi chạy ứng dụng mặc định (`Counter App`) lên thiết bị giả lập hoặc trình duyệt Chrome.
* **Thử nghiệm Hot Reload:** Thực hiện thay đổi tiêu đề ứng dụng trong mã nguồn (`lib/main.dart`) sang tên mong muốn, nhấn lưu và chụp ảnh minh chứng tính năng Hot Reload hoạt động thành công.

## 2. Các Kiến Thức Cốt Lõi Cần Nắm Chắc (Core Knowledge)
* **Kiến trúc cơ bản của Flutter:** Nguyên lý hoạt động của Flutter Engine và cách hệ thống render đồ họa đa nền tảng từ một nguồn mã nguồn duy nhất (Single Codebase).
* **Công cụ chẩn đoán `flutter doctor`:** Cách đọc hiểu báo cáo trạng thái hệ thống, phân biệt ý nghĩa các ký hiệu `[✓]` (Sẵn sàng), `[!]` (Cấu hình thiếu/Cần chú ý) và `[X]` (Chưa cài đặt).
* **Quản lý Android Toolchain & Licenses:** Cách cài đặt bộ công cụ dòng lệnh `Android SDK Command-line Tools` và chấp thuận các điều khoản bản quyền bằng lệnh `flutter doctor --android-licenses`.
* **Cấu trúc thư mục dự án Flutter:** Nắm rõ vai trò của các thư mục:
  * `lib/`: Nơi chứa mã nguồn Dart chính của ứng dụng.
  * `android/`, `ios/`, `web/`: Các lớp vỏ nền tảng gốc chứa file cấu hình riêng cho từng hệ điều hành.
  * `pubspec.yaml`: File quản lý tài nguyên tĩnh và khai báo các thư viện phụ thuộc (dependencies).

## 3. Sau Khi Làm Xong Được Gì? (Key Skills)
* Khởi tạo thành công môi trường lập trình Flutter ổn định trên máy tính cá nhân.
* Tạo mới và khởi chạy thành công ứng dụng đầu tiên lên trình duyệt Chrome hoặc thiết bị ảo/thật mà không gặp lỗi biên dịch.
* Làm chủ tính năng **Hot Reload** thần tốc để cập nhật giao diện ngay lập tức trong vòng chưa đầy 1 giây mà không phải biên dịch lại từ đầu, tối ưu hóa tốc độ phát triển giao diện.