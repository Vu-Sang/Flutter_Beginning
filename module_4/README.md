# BÁO CÁO THU HOẠCH: MODULE 4 – FLUTTER UI FUNDAMENTALS

## 1. Đề Bài Yêu Cầu Gì? (Lab 4 Requirements)
Hoàn thành 5 bài tập xây dựng giao diện người dùng sử dụng hệ thống widget cốt lõi của Flutter:
* **Exercise 1 (Core Widgets):** Tạo màn hình hiển thị sử dụng tập hợp các widget cơ bản gồm `Text` (tiêu đề), `Icon` Material, ảnh mạng `Image.network()` và một khối `Card` chứa `ListTile` bên trong.
* **Exercise 2 (Input Widgets):** Tạo một màn hình tương tác chứa `Slider` (thanh trượt), `Switch` (công tắc logic), nhóm lựa chọn duy nhất `RadioListTile` và một nút kích hoạt hộp thoại chọn lịch `DatePicker`.
* **Exercise 3 (Layout Composition):** Sắp xếp giao diện phân vùng dọc bằng `Column`, căn chỉnh spacing đồng nhất bằng `Padding`/`SizedBox` và render danh sách phim động thông qua `ListView.builder`.
* **Exercise 4 (App Structure):** Xây dựng bộ khung ứng dụng hoàn chỉnh bằng `Scaffold` chứa `AppBar`, `Body` và nút bấm nổi `FloatingActionButton`, đồng thời thiết lập tùy biến hệ màu sắc hệ thống `ThemeData` để làm tính năng bật/tắt chế độ giao diện Sáng/Tối (Dark Mode Toggle).
* **Exercise 5 (Debug & Fix UI Errors):** Phát hiện và sửa đổi triệt để các lỗi giao diện kinh điển: Lỗi vô hạn chiều cao của ListView trong Column, lỗi tràn khung hình trên màn hình nhỏ, lỗi không cập nhật lại UI khi biến đổi giá trị, và lỗi sai Context của bộ chọn Picker.

## 2. Các Kiến Thức Cốt Lõi Cần Nắm Chắc (Core Knowledge)
* **Phân biệt Stateless vs Stateful Widget:** Hiểu khi nào dùng widget tĩnh (chỉ hiển thị dữ liệu) và khi nào dùng widget động (có khả năng lưu giữ biến và thay đổi trạng thái giao diện).
* **Hàm làm mới giao diện setState():** Cơ chế kích hoạt vẽ lại (Rebuild) Widget Tree ngay khi người dùng tương tác thay đổi giá trị đầu vào để cập nhật UI kịp thời.
* **Trục bố cục Column & Row:** Cách căn chỉnh không gian dọc/ngang thông qua hai thuộc tính quyết định `mainAxisAlignment` và `crossAxisAlignment`.
* **Tối ưu hóa ListView:** Hiểu cơ chế nạp bộ nhớ thông minh của `ListView.builder` cho các danh sách dài thay vì nạp toàn bộ phần tử cùng một lúc.
* **Cơ chế Theming:** Cách cấu hình hệ màu chủ đạo thông qua `ColorScheme.fromSeed` kết hợp kiểm soát trạng thái bằng `themeMode`.

## 3. Sau Khi Làm Xong Được Gì? (Key Skills)
* Khả năng chuyển đổi ý tưởng thiết kế đồ họa hoặc hình ảnh mock-up thành code ứng dụng Flutter chạy được trên thực tế với bố cục responsive co giãn mượt mà.
* Làm chủ kỹ thuật điều khiển dữ liệu động đầu vào từ người dùng (User Inputs) trên các cấu phần biểu mẫu.
* Thành thạo kỹ năng gỡ lỗi giao diện thực chiến: xử lý triệt để lỗi sọc vàng đen tràn màn hình bằng `SingleChildScrollView` và lỗi vô hạn chiều dọc `Unbounded Height` bằng cách giới hạn không gian bao bọc.