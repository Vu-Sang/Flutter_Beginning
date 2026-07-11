# BÁO CÁO THU HOẠCH: LAB 7 – FORMS & VALIDATION

## 1. Đề Bài Yêu Cầu Gì? (Lab 7 Requirements)
Thiết kế và triển khai một biểu mẫu đăng ký thành viên (Signup Form) hoàn chỉnh chạy trên môi trường Flutter, đáp ứng toàn diện các tiêu chí kỹ thuật và trải nghiệm người dùng (UX):
* **Cấu trúc Form nhập liệu:** Thu thập đầy đủ 4 trường thông tin bắt buộc bao gồm: Full Name (Họ và tên), Email Address (Địa chỉ email), Password (Mật khẩu chính) và Confirm Password (Xác nhận mật khẩu).
* **Hệ thống quy tắc kiểm lỗi đồng bộ (Synchronous Validation):**
  * Tất cả các trường dữ liệu đều bắt buộc, không được phép để trống hoặc chỉ chứa ký tự cách.
  * Trường Email phải tuân thủ định dạng cơ bản (chứa ít nhất ký tự `@` và dấu chấm `.`).
  * Trường Mật khẩu phải đạt độ mạnh tối thiểu: dài ít nhất 8 ký tự và phải chứa ít nhất 1 chữ số.
  * Trường Xác nhận mật khẩu bắt buộc phải trùng khớp hoàn toàn với mật khẩu chính đã nhập.
* **Quản lý hành vi và Tiêu điểm bàn phím (Focus & Keyboard Management):**
  * Sử dụng `FocusNode` kết hợp `textInputAction` để tự động chuyển con trỏ xuống ô tiếp theo khi nhấn phím `Next` trên bàn phím ảo.
  * Cấu hình phím `Done` cho ô nhập cuối cùng để tự động kích hoạt tiến trình gửi form.
  * Ẩn bàn phím ảo một cách tự nhiên khi người dùng chạm (tap) vào bất kỳ vùng trống nào bên ngoài biểu mẫu.
* **Kiểm lỗi bất đồng bộ (Asynchronous Validation):** Giả lập một tiến trình kiểm tra trùng lặp email hệ thống thông qua gọi API (trì hoãn 2 giây). Nếu email bắt đầu bằng từ khóa "taken", hệ thống sẽ chặn lại và báo lỗi tài khoản đã tồn tại.

## 2. Các Kiến Thức Cốt Lõi Cần Nắm Chắc (Core Knowledge)
* **GlobalKey<FormState> và Nhân FormState:** Hiểu cách sử dụng khóa toàn cục để truy cập vào trạng thái hiện tại của Form nhằm kích hoạt đồng loạt các phương thức xử lý lỗi (`validate()`), lưu dữ liệu (`save()`), hoặc đặt lại trạng thái ban đầu (`reset()`).
* **Cơ chế AutovalidateMode:** Phân biệt và áp dụng cấu hình `AutovalidateMode.onUserInteraction` để biểu mẫu tự động kiểm tra và hiển thị thông báo lỗi ngay trong quá trình người dùng đang gõ chữ, tăng tính tương tác chủ động.
* **Tiêu điểm FocusNode và FocusScope:** Cách thức tổ chức điều hướng con trỏ văn bản tuần tự bằng lệnh `FocusScope.of(context).requestFocus()` giúp người dùng thao tác nhập liệu mượt mà, liền mạch.
* **Chống tràn màn hình do bàn phím ảo:** Hiểu bản chất việc bọc toàn bộ bố cục trong `SingleChildScrollView` nhằm tạo không gian cuộn tự động, triệt tiêu lỗi sọc vàng đen khi bàn phím ảo chiếm dụng diện tích hiển thị.
* **Phản hồi trạng thái nút bấm (Button States UX):** Kỹ thuật vô hiệu hóa nút bấm bằng cách truyền giá trị `null` cho sự kiện `onPressed` khi hệ thống đang xử lý tác vụ ngầm, kết hợp thay thế văn bản thành `CircularProgressIndicator` nhằm mang lại phản hồi trực quan tốt nhất cho người dùng.

## 3. Sau Khi Làm Xong Được Gì? (Key Skills)
* Có năng lực xây dựng các biểu mẫu thu thập thông tin phức tạp (Complex Forms) an toàn dữ liệu, thiết lập các bộ lọc kiểm lỗi chặt chẽ trước khi gửi dữ liệu lên Server.
* Làm chủ kỹ năng xử lý các tương tác phần cứng trên thiết bị di động liên quan đến bàn phím ảo, tối ưu hóa trải nghiệm điền biểu mẫu (Form UX).
* Thành thạo tư duy phối hợp giữa logic kiểm lỗi đồng bộ tại chỗ (Local Validation) song hành cùng logic bất đồng bộ (Server API Check Validation) trong việc xây dựng các tính năng xác thực tài khoản thực chiến.