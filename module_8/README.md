# BÁO CÁO THU HOẠCH: MODULE 8 – NETWORKING & JSON

## 1. Đề Bài Yêu Cảo Gì? (Lab 8 Requirements)
Thiết kế và xây dựng màn hình kết nối API hoàn chỉnh từ một file đơn, áp dụng mô hình phân tách nghiệp vụ mạng độc lập:
* **Tích hợp Gọi API Public:** Sử dụng gói thư viện lõi HTTP để tạo yêu cầu GET lấy dữ liệu mạng từ endpoint công khai `https://jsonplaceholder.typicode.com/posts`.
* **Phân rã dữ liệu mạng:** Chuyển đổi chuỗi String thô JSON nhận về từ mạng internet bằng phương thức `json.decode()` kết hợp Factory Model mapping tự động sang cấu trúc `List<Post>`.
* **Xử lý trạng thái bất đồng bộ trên UI:** Ứng dụng mô hình `FutureBuilder` để bắt trọn vẹn 3 trạng thái luồng: Đang đợi tải dữ liệu (Loading spinner), Gặp sự cố mạng (Hiện thông báo lỗi kèm nút thử lại) và Hiển thị dữ liệu thành công (Danh sách ListView cuộn dọc).
* **Kiến trúc Service Layer:** Bắt buộc tách toàn bộ logic xử lý mạng sang lớp đối tượng `ApiService`, giữ tầng UI tập trung duy nhất vào nhiệm vụ hiển thị giao diện cấu phần.
* **Tác vụ Gửi dữ liệu nâng cao (POST):** Thiết kế biểu mẫu phụ cho phép điền thông tin bài viết và bắn yêu cầu POST đẩy dữ liệu ngược lại máy chủ Server để nhận phản hồi trạng thái 201.

## 2. Các Kiến Thức Cốt Lõi Cần Nắm Chắc (Core Knowledge)
* **Vận hành FutureBuilder:** Cơ chế tự động lắng nghe trạng thái của một biến tương lai tương tác (`AsyncSnapshot`) nhằm đưa ra các quyết định phân phối Widget cây hiển thị phù hợp theo thời gian thực mà không phải quản lý setState thủ công.
* **Cơ chế Serialization/Deserialization JSON:** Bản chất phân rã chuỗi nhị phân truyền dẫn trên internet thông qua hàm phân tích cấu trúc của Dart, chuyển đổi linh hoạt dữ liệu Map sang lớp đối tượng Object tường minh thông qua cấu trúc Constructor Factory.
* **Mẫu kiến trúc Service Layer Pattern:** Hiểu lý do và lợi ích của việc cô lập mã nguồn mạng ra khỏi tầng View. Giúp mã nguồn dễ bảo trì, dễ dàng thay thế endpoint và tối ưu hóa cho viết kiểm thử tự động (Unit Test).
* **Exception Handling (Bắt lỗi ngoại lệ mạng):** Cách dùng các cấu trúc `try-catch`, thiết lập thời gian ngắt kết nối (`timeout`) nhằm bảo vệ ứng dụng khỏi hiện tượng treo ứng dụng (Freeze UI) khi máy chủ gặp sự cố sập mạng.

## 3. Sau Khi Làm Xong Được Gì? (Key Skills)
* Làm chủ kỹ năng kết nối ứng dụng Flutter với các dịch vụ lưu trữ đám mây, Server, hay REST API bên ngoài phục vụ hiển thị dữ liệu thực tế.
* Có năng lực xử lý giao diện bất đồng bộ chuẩn chuyên nghiệp, loại bỏ hoàn toàn các lỗi trải nghiệm người dùng xấu do màn hình trống không có dữ liệu phản hồi.
* Nắm chắc tư duy lập trình Clean Code phân mảnh nghiệp vụ mạng ra khỏi màn hình UI, chuẩn bị hành trang nâng cấp lên các kiến trúc lớn cấp doanh nghiệp.