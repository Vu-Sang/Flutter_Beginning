# BÁO CÁO THU HOẠCH: LAB 8B – REST API PRACTICAL INTEGRATION

## 1. Mô tả Ứng dụng & Kịch bản lựa chọn (Scenario Selection)
* **Kịch bản lựa chọn:** Scenario A – Weather Companion App (Ứng dụng Trợ lý Thời tiết).
* **Vấn đề ứng dụng giải quyết thực tế (Problem Solved):** Giúp người dùng đưa ra các quyết định nhanh chóng trong ngày như: "Có cần thiết phải đem theo ô (dù) che mưa đi học/đi làm không?" hay "Hôm nay thời tiết có lý tưởng để tham gia các hoạt động thể thao chạy bộ ngoài trời không?".

## 2. Thiết kế Cấu trúc Hệ thống (System Architecture)
Ứng dụng được thiết kế tuân thủ nghiêm ngặt mô hình phân tách nghiệp vụ Service Layer Pattern:
* **Tầng dữ liệu (Model Layer - `WeatherData`):** Định nghĩa mô hình dữ liệu ánh xạ trực tiếp từ JSON thô của API thông qua phương thức `factory WeatherData.fromJson()`. Tích hợp sẵn bộ lọc phân tích (Heuristics) để tự động hóa đưa ra các khuyến nghị thời tiết.
* **Tầng kết nối dịch vụ (Service Layer - `WeatherService`):** Đóng gói logic gọi HTTP GET gửi tới API mở Open-Meteo để lấy tọa độ thời tiết thực tế, thiết lập thời gian chờ tối đa (timeout) tránh treo ứng dụng.
* **Tầng hiển thị (Presentation Layer - `WeatherHomeScreen`):** Sử dụng `FutureBuilder` để liên kết luồng bất đồng bộ, phân chia vẽ giao diện theo đúng trạng thái phản hồi.

## 3. Quản lý trạng thái Bất đồng bộ & Trải nghiệm Người dùng (Async UX)
Hệ thống xử lý mượt mà và trực quan qua 3 trạng thái cốt lõi:
* **Loading State (Đang tải):** Hiển thị màn hình xoay tròn tiến trình kèm thông báo "Analyzing live atmosphere data..." giúp người dùng hiểu hệ thống đang kết nối internet.
* **Error State (Gặp sự cố mạng):** Khi mất mạng hoặc xảy ra lỗi biên dịch API, màn hình sẽ hiển thị biểu tượng đám mây ngắt kết nối kèm chi tiết thông tin lỗi và một nút "Try Again" (Thử lại) cho phép người dùng kích hoạt tải lại tức thì mà không cần tắt app.
* **Success State (Tải thành công):** Hiển thị đầy đủ thông số độ ẩm, nhiệt độ, sức gió kèm theo phần "Companion Advice" đưa ra các đề xuất thiết thực dựa trên số liệu thời tiết thực tế nhận được.