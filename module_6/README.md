# BÁO CÁO THU HOẠCH: MODULE 6 – RESPONSIVE UI & ADAPTIVE LAYOUTS

## 1. Đề Bài Yêu Cầu Gì? (Lab 6 Requirements)
* **Xây dựng Màn hình Duyệt Phim Responsive:** Thiết kế một màn hình tìm kiếm và phân loại phim đa năng thích ứng mượt mà trên nhiều kích thước màn hình (Phone, Tablet, Web) từ một file duy nhất.
* **Tích hợp các Cấu phần Chức năng:**
  * Khối Header chứa tiêu đề ứng dụng cứng “Find a Movie”.
  * Thanh tìm kiếm lọc phim không phân biệt chữ hoa/thường theo tiêu đề.
  * Nhóm các thẻ phân loại thể loại (Genre Chips) có tính năng bật/tắt bộ lọc bằng widget Wrap.
  * Thanh điều khiển Dropdown Button để sắp xếp danh sách kết quả (theo thứ tự tên A-Z, Z-A, Năm, Điểm số).
* **Xử lý Breakpoint Đồ họa:**
  * Khi giao diện có chiều rộng hiển thị nhỏ hơn 800px (Điện thoại): Ép danh sách phim xếp chồng cuộn dọc 1 cột (ListView).
  * Khi giao diện có chiều rộng lớn hơn hoặc bằng 800px (Máy tính bảng/Màn hình máy tính): Tự động chuyển đổi giao diện phim sang dạng lưới phân bổ đều thành 2 cột song song (GridView).

## 2. Các Kiến Thức Cốt Lõi Cần Nắm Chắc (Core Knowledge)
* **Cơ chế hoạt động của LayoutBuilder:** Cách khai báo và sử dụng `BoxConstraints` để đọc dữ liệu không gian thực tế đang có của vùng chứa, từ đó đưa ra quyết định dựng cây Widget tối ưu dựa theo kích thước ranh giới (`constraints.maxWidth`), thay vì fix cứng tên thiết bị.
* **Widget Wrap thích ứng:** Sự khác biệt của `Wrap` so với `Row` — tự động đẩy các phần tử con xuống hàng tiếp theo khi chạm viền giới hạn ngang của màn hình, chống hoàn toàn lỗi tràn khung.
* **Lập trình hàm lọc Collection cấp cao:** Vận hành thành thạo chuỗi các phương thức xử lý mảng của Dart (`.where()`, `.contains()`, `.toLowerCase()`, và `.sort()`) trực tiếp bên trong hàm `build()` để tạo ra một danh sách động kết quả thay đổi ngay lập tức sau mỗi click của người dùng.
* **Tối ưu hóa hiển thị với SafeArea:** Cách bao bọc ứng dụng để lớp giao diện tự động co giãn, tránh được các vùng khuyết tật vật lý của phần cứng (Vùng tai thỏ, camera nốt ruồi hay thanh điều hướng hệ thống).

## 3. Sau Khi Làm Xong Được Gì? (Key Skills)
* Sở hữu tư duy lập trình giao diện Responsive & Adaptive nâng cao, tự tin làm ra các sản phẩm app chạy mượt mà trên cả điện thoại di động lẫn giao diện hiển thị máy tính tính bảng/Web Desktop.
* Làm chủ kỹ thuật điều khiển bộ lọc đa điều kiện đồng thời (Tìm kiếm từ khóa + Tích chọn nhiều thể loại kết hợp đồng bộ hóa sắp xếp dữ liệu).
* Triệt tiêu hoàn toàn lỗi sọc sọc vàng đen nguy hiểm cảnh báo tràn bộ nhớ giao diện (`Overflow`) nhờ việc ứng dụng nhuần nhuyễn `LayoutBuilder`, `Wrap`, và `Expanded`.