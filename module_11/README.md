# DEBUGGING REPORT: TASKLY APP PERFORMANCE & LAYOUT ANALYSIS

## 1. Phát hiện lỗi giao diện tiềm ẩn (Potential Layout Issue)
* **Vấn đề phát hiện:** Khi danh sách Task trở nên quá dài và tràn màn hình, việc dùng cột tĩnh (`Column`) mà không có phần tử cuộn giới hạn sẽ gây ra hiện tượng tràn hiển thị thiết bị (Bottom Overflow).
* **Giải pháp khắc phục:** Cần bọc phần danh sách bằng widget `Expanded` kết hợp `ListView.builder` (như đã triển khai trong mã nguồn dự án) để tối ưu không gian hiển thị linh hoạt theo kích thước vật lý màn hình.

## 2. Phát hiện lỗi hiệu năng tiềm ẩn (Potential Performance Issue)
* **Vấn đề phát hiện:** Việc gọi phương thức thay đổi trạng thái giao diện `setState()` ngay tại Widget gốc của trang chủ `TaskListScreen` sẽ bắt buộc toàn bộ cây Widget (bao gồm cả ô TextField và nút Add) phải vẽ lại (Rebuild) không cần thiết khi người dùng chỉ bấm tích chọn Checkbox hoàn thành một Task.
* **Giải pháp khắc phục:** Cần tách thành phần Task Item thành một StatefulWidget con độc lập để thu hẹp phạm vi rebuild cục bộ, tối ưu hóa FPS khi ứng dụng hoạt động lâu dài.

## 3. Vai trò của DevTools & Test Suite trong việc phát hiện lỗi
* **Widget Inspector:** Giúp theo dõi trực quan cây phân cấp giao diện (Widget Tree), xem chi tiết các ràng buộc kích thước (`Constraints`) để phát hiện nhanh các vùng gây lỗi giao diện.
* **Performance Timeline:** Hỗ trợ theo dõi chu kỳ quét khung hình (khắc phục hiện tượng giật lag màn hình - Jank) thông qua biểu đồ FPS thời gian thực.
* **Test Suite:** Chặn đứng các lỗi logic hồi quy (Regression) ngay khi nâng cấp mã nguồn, giúp mã nguồn luôn ổn định và hoạt động chính xác theo cam kết ban đầu.