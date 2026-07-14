# BÁO CÁO THU HOẠCH: MODULE 10 – AUTHENTICATION & NOTIFICATIONS

## 1. Đề Bài Yêu Cầu Gì? (Lab 10 Requirements)
Xây dựng chuỗi quy trình xác thực và kiểm soát hoạt động phiên người dùng khép kín, tích hợp sâu thông báo đẩy nội bộ:
* **Xác thực API thực tế (Lab 10.2):** Thay thế các lớp mô phỏng bằng việc kết nối và bắn dữ liệu POST trực tiếp lên cổng xác thực DummyJSON.
* **Quản lý trạng thái phiên (Lab 10.3):** Lưu trữ mã Token thu về thông qua bộ nhớ đệm `SharedPreferences` nhằm thiết lập cơ chế tự động đăng nhập (Auto-login) khi mở lại app và dọn sạch dấu vết khi nhấn Đăng xuất.
* **Thông báo đẩy nội bộ (Lab 10.5 - LO7):** Thiết lập kênh giao tiếp thông tin `flutter_local_notifications`, tự động hiển thị thông báo biểu ngữ trên thanh trạng thái của hệ điều hành ngay khi người dùng đăng nhập hoặc đăng xuất thành công.

## 2. Các Kiến Thức Cốt Lõi Cần Nắm Chắc (Core Knowledge)
* **Luồng hoạt động của Splash Screen:** Cơ chế hoạt động của màn hình chờ trung gian, chịu trách nhiệm truy cập đọc bộ nhớ máy trước để phân luồng điều hướng màn hình (Home hoặc Login) giúp tăng tốc độ trải nghiệm và độ mượt của ứng dụng.
* **Xác thực Token-based (Bearer Authentication):** Hiểu cách thức hoạt động của Token do API phản hồi, đóng vai trò như một chiếc chìa khóa thông hành để gửi kèm trong các header của các request bảo mật phía sau.
* **Cơ chế Notification Channel trên Android:** Nắm vững cấu hình kênh thông báo độc lập (Channel ID, Name, Importance) để phân cấp mức độ ưu tiên hiển thị và âm thanh thông báo trên các thiết bị di động.

## 3. Sau Khi Làm Xong Được Gì? (Key Skills)
* Có khả năng thiết kế và hoàn thiện toàn bộ hệ thống quản lý tài khoản, phân quyền bảo mật chuyên nghiệp theo quy chuẩn bảo mật di động.
* Đạt chuẩn đầu ra tích hợp thông báo nội bộ (LO7 - Mobile Notifications Integration) của chương trình học, tăng cường tương tác thời gian thực giữa ứng dụng và người dùng.
* Nắm chắc tư duy quản lý phiên hoạt động (Session persistence), giữ chân người dùng trong ứng dụng một cách tối ưu.