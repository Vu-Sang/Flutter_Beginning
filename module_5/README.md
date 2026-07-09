# BÁO CÁO THU HOẠCH: MODULE 5 – NAVIGATION & STATE MANAGEMENT

## 1. Đề Bài Yêu Cầu Gì? (Lab 5 Requirements)
Thiết kế và xây dựng một ứng dụng xem thông tin phim hoàn chỉnh gồm hai màn hình (Movie Detail App) chuyển động mượt mà và xử lý dữ liệu thông qua bộ nhớ tĩnh mẫu:
* **Home Screen:** Hiển thị danh sách cuộn dọc các bộ phim chứa ảnh đại diện thu nhỏ (poster), tiêu đề phim (title), điểm số và thể loại (rating & genres) sử dụng thẻ `Card` phối `ListTile`. Khi nhấn vào một bộ phim bất kỳ, hệ thống sẽ tự động điều hướng sang màn hình tiếp theo.
* **Movie Detail Screen:** Hiển thị thông tin chi tiết toàn diện của phim bao gồm:
  * Ảnh nền biểu ngữ đầu trang (Hero banner) xếp chồng tên phim phối hiệu ứng mờ Gradient.
  * Danh mục các thể loại hiển thị dưới dạng các thẻ bo góc (Chips).
  * Đoạn văn ngắn mô tả tóm tắt nội dung cốt truyện (Overview text).
  * Hàng nút hành động tương tác gồm: Yêu thích (Favorite), Chấm điểm (Rate), và Chia sẻ (Share).
  * Danh sách các video clip liên quan (Trailers list) sử dụng ListView.builder lồng bên trong trang.
* **Yêu cầu kỹ thuật:** Hệ thống điều hướng bắt buộc phải sử dụng `Navigator.push` kết hợp `MaterialPageRoute` (hoặc đặt tên Named Routes) để truyền nguyên vẹn một Đối tượng (`Movie Object`) sang màn hình đích, và quay về hợp lệ bằng nút Back hoặc hàm `Navigator.pop`.

## 2. Các Kiến Thức Cốt Lõi Cần Nắm Chắc (Core Knowledge)
* **Mô hình Stack-based Navigation:** Hiểu cách Flutter quản lý lịch sử các màn hình dưới dạng một ngăn xếp (Stack) - cơ chế đẩy lên (`Push`) màn hình mới và rút xuống (`Pop`) để hủy màn hình hiện tại.
* **Truyền dữ liệu qua Hàm khởi tạo (Constructor Passing):** Kỹ thuật đính kèm dữ liệu từ màn hình cha sang màn hình con và cách lớp `State` truy cập dữ liệu của Widget thông qua từ khóa tham chiếu `widget.property`.
* **Khối xếp chồng Stack & Gradient:** Cách dùng `Stack` phối hợp với lớp phủ `LinearGradient` để lồng ghép hình ảnh và văn bản mà không làm mất tính tương phản chữ nền.
* **Bố cục tự động Wrap:** Cách dùng `Wrap` thay vì `Row` khi render danh sách Chips thể loại để các phần tử tự động xuống dòng thông minh khi vượt quá chiều ngang màn hình.
* **Giải quyết xung đột lồng cuộn (Nested Scroll Fix):** Nắm rõ việc thiết lập thuộc tính `shrinkWrap: true` và `physics: NeverScrollableScrollPhysics()` khi đặt một ListView danh sách bên trong một trang cuộn tổng thể SingleChildScrollView nhằm triệt tiêu lỗi xung đột thanh cuộn dọc.

## 3. Sau Khi Làm Xong Được Gì? (Key Skills)
* Có năng lực thiết kế kiến trúc và xây dựng hoàn chỉnh luồng chuyển động đa màn hình (Multi-screen App Architect) chuyên nghiệp, responsive trên mọi kích thước thiết bị.
* Làm chủ kỹ thuật điều khiển và đồng bộ hóa trạng thái dữ liệu (State Management) như cập nhật nút Yêu thích thời gian thực đổi màu sắc động bằng `setState()`.
* Nắm giữ tư duy lập trình Clean Code phân tầng thư mục khoa học (`models/`, `screens/`, `main.dart`), tạo nền tảng vững chắc để học các mô hình quản lý luồng dữ liệu kiến trúc lớn sau này của Flutter như BLoC hay Riverpod.