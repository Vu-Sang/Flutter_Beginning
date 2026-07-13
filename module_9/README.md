# BÁO CÁO THU HOẠCH: MODULE 9 – JSON & LOCAL STORAGE

## 1. Đề Bài Yêu Cầu Gì? (Lab 9 Requirements)
Xây dựng và triển khai hệ thống lưu trữ tệp dữ liệu cục bộ (Local File Persistence) dưới định dạng JSON, đóng vai trò như một cơ sở dữ liệu thu nhỏ (Mini Database) để quản lý thông tin:
* **Lab 9.1 (Đọc JSON từ Assets):** Thiết lập tệp cấu trúc gốc `movies.json` nhúng sẵn vào mã nguồn dự án, gọi nạp bất đồng bộ thông qua `rootBundle.loadString()` và render ra màn hình ListView hiển thị tối thiểu 2 trường dữ liệu mẫu.
* **Lab 9.2 (Lưu trữ bộ nhớ thiết bị):** Sử dụng gói thư viện lõi hệ thống để định vị phân vùng ứng dụng trong ổ cứng vật lý (`ApplicationDocumentsDirectory`), thực hiện nhân bản, đọc và viết đè dữ liệu tệp thô trực tiếp trên thiết bị di động nhằm bảo toàn dữ liệu khi khởi động lại ứng dụng.
* **Lab 9.3 (Tương tác CRUD + Search):** Thiết kế hoàn chỉnh các tác vụ điều khiển dữ liệu động bao gồm: Thêm phim mới (Tự sinh khóa ID), Chỉnh sửa nội dung phim, Xóa bỏ phim (Có hộp thoại xác thực) và Thanh tìm kiếm lọc từ khóa theo thời gian thực. Toàn bộ các hành vi CRUD bắt buộc phải kích hoạt lưu tệp tự động (Auto-save) xuống bộ nhớ.

## 2. Các Kiến Thức Cốt Lõi Cần Nắm Chắc (Core Knowledge)
* **Cơ chế nạp Bundled Assets:** Bản chất luồng nạp chuỗi tĩnh thông qua gói thư viện phần cứng của Flutter, giúp ứng dụng có dữ liệu mặc định chạy thử ngay từ lần đầu tiên cài đặt app.
* **Phân biệt Nhân tệp hệ thống (File I/O):** Cách dùng các phương thức `readAsString()` và `writeAsString()` của thư viện `dart:io` để chuyển hóa dòng dữ liệu RAM thành văn bản ghi nhớ vĩnh viễn.
* **Mã hóa và Giải mã JSON nâng cao:** Thành thạo cặp hàm xử lý mảng lõi: `jsonDecode()` (Phân rã chuỗi văn bản internet/file thành cấu trúc mảng Dart sử dụng được) và `jsonEncode()` (Mã hóa mảng đối tượng động trong RAM thành chuỗi văn bản thô phục vụ việc lưu trữ xuống file).
* **Quản lý dữ liệu in-memory:** Tư duy thao tác xử lý mảng dữ liệu song hành cục bộ (lọc mảng hiển thị thông qua từ khóa search, đồng bộ cập nhật phần tử dựa theo chỉ số định danh `id` duy nhất) nhằm đồng bộ giao diện kịp thời cùng luồng dữ liệu tệp tin ổ cứng.

## 3. Sau Khi Làm Xong Được Gì? (Key Skills)
* Có năng lực thiết kế hệ thống lưu trữ dữ liệu offline (Offline Data Persistence) hoàn chỉnh cho ứng dụng mà không bắt buộc phụ thuộc hoàn toàn vào kết nối mạng Internet hay máy chủ Cloud API.
* Làm chủ kỹ năng thao tác File System trên các hệ điều hành điện thoại di động (Android, iOS), bảo vệ cấu trúc dữ liệu toàn vẹn xuyên suốt các vòng đời đóng mở của ứng dụng.
* Thành thạo tư duy xây dựng trọn vẹn 4 nghiệp vụ phần mềm cốt lõi (Create - Read - Update - Delete) đi kèm giao diện phản hồi người dùng UX tốt (SnackBar, Confirm Dialog, Loading States).