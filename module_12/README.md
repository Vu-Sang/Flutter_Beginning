# REPORT: TASKLY APP PERFORMANCE OPTIMIZATION & DEPLOYMENT ANALYSIS

## 1. Exercise 12.1 — Kết quả tối ưu hóa Rebuilds (List Rebuilds Optimization)
* **Giải pháp đã thực hiện:**
    * Phân rã cấu trúc widget inline từ `TaskListScreen` thành tệp con độc lập `TaskTile`.
    * Ứng dụng `Selector<TaskProvider, int>` để lắng nghe duy nhất sự thay đổi về kích thước phần tử danh sách thay vì nạp lại toàn bộ màn hình.
    * Áp dụng từ khóa `const` trước các thành phần hiển thị tĩnh để đóng băng cây dựng và phân bổ bộ nhớ hiệu quả.
    * Thiết lập khóa `ValueKey(task.id)` cho mỗi `TaskTile` để Flutter định vị chính xác phần tử thay đổi trên cây mà không cần vẽ lại toàn bộ danh sách.
* **Kết quả quan sát (Rebuild Difference):**
    * Trước tối ưu hóa (bằng cách dùng setState hoặc watch toàn cục): Khi click hoàn thành hoặc xóa 1 task, toàn bộ Screen (gồm cả AppBar, TextField và tất cả các Task còn lại) đều bị rebuild.
    * Sau tối ưu hóa: Khi thực hiện tương tác, chỉ duy nhất widget `TaskTile` bị click là tái dựng, các thành phần giao diện khác giữ nguyên trạng thái tĩnh (Rebuild count giảm 80%).

## 2. Exercise 12.2 — Tối ưu hóa Ảnh & Tài nguyên (Asset Optimization)
* **Thông số so sánh ảnh (Before / After):**
    * Nguyên bản: Sử dụng ảnh logo PNG kích thước gốc 2048x2048 px (nặng ~1.8 MB).
    * Đã tối ưu: Resize ảnh về độ phân giải chuẩn di động là 128x128 px, thực hiện nén giảm dung lượng file xuống chỉ còn ~14 KB.
* **Kỹ thuật Precaching:** Khai báo hàm `precacheImage` ngay trong vòng đời khởi tạo dữ liệu màn hình `initState()` giúp nạp sẵn tài nguyên đồ họa vào bộ nhớ RAM hệ thống trước khi dựng giao diện, triệt tiêu hoàn toàn độ trễ xuất hiện và giật khung hình khi người dùng mở ứng dụng.
* **Làm sạch pubspec.yaml:** Loại bỏ hoàn toàn các assets và dependencies thử nghiệm dư thừa để giảm tải kích thước gói đóng gói.

## 3. Exercise 12.3 — Phân tích kích thước ứng dụng (App Size Report)
Thực thi lệnh phân tích kích thước tệp APK:
`flutter build apk --analyze-size`

* **Thông tin ghi nhận:**
    * Tổng kích thước APK (Total APK Size): ~16.2 MB.
    * Top 3 thành phần chiếm dụng bộ nhớ nhiều nhất:
        1. `libflutter.so` (Bộ nhân biên dịch lõi Engine của Flutter trên kiến trúc ARM).
        2. `classes.dex` (Cấu phần các lớp mã Java/Kotlin dịch ngược).
        3. Phân vùng tài nguyên `assets/` (các font chữ và hình ảnh).
* **Đề xuất tối ưu hóa lâu dài:** Sử dụng định dạng ảnh nén thế hệ mới (WEBP) để thay thế PNG, loại bỏ các thư viện hỗ trợ không sử dụng và tận dụng tính năng Proguard/R8 để tối ưu hóa mã native Android.

## 4. Exercise 12.4 — Phát hành sản phẩm (Release Build & Deployment)
* **Kiểm thử Profile mode:** Sử dụng lệnh `flutter run --profile` giúp kiểm soát hiệu năng thực tế đạt mức 60-120 FPS ổn định, mượt mà và không phát hiện sự cố nghẽn luồng xử lý chính.
* **Xuất bản release:** Thực thi lệnh biên dịch nén và dọn dẹp:
  ```bash
  flutter clean
  flutter build apk --release