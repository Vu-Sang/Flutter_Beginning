import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 7 - Signup Form Validation',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      home: const SignupScreen(),
    );
  }
}

// ============================================================================
// STATEFUL WIDGET ĐIỀU KHIỂN CHÍNH FORM ĐĂNG KÝ
// ============================================================================
class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  // 1. Tạo GlobalKey để quản lý và kiểm tra trạng thái FormState
  final _formKey = GlobalKey<FormState>();

  // 2. Các biến lưu trữ giá trị nhập liệu (State Variables)
  String _fullName = '';
  String _email = '';
  String _password = '';
  String _confirmPassword = '';

  // 3. Các biến trạng thái bổ trợ (Bonus & Async State)
  bool _isCheckingEmail = false; // Trạng thái đợi kiểm tra Email bất đồng bộ [
  bool _obscurePassword = true;  // Ẩn/hiện mật khẩu chính
  bool _obscureConfirmPassword = true; // Ẩn/hiện mật khẩu xác nhận
  bool _acceptTerms = false;     // Trạng thái đồng ý điều khoản

  // 4. Khai báo các FocusNode để điều khiển di chuyển bàn phím thông minh
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _confirmPasswordFocusNode = FocusNode();

  // 5. Hàm giải phóng bộ nhớ của FocusNode khi widget bị huỷ
  @override
  void dispose() {
    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  // ============================================================================
  // TẦNG XỬ LÝ VALIDATORS (TÁCH HÀM RIÊNG BIỆT THEO YÊU CẦU ĐỀ BÀI) [cite: 408]
  // ============================================================================

  // Kiểm tra Họ và Tên
  String? _validateFullName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Full name is required';
    }
    return null;
  }

  // Kiểm tra định dạng Email
  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }
    // Kiểm tra định dạng có chứa ký tự @ và dấu chấm .
    if (!value.contains('@') || !value.contains('.')) {
      return 'Enter a valid email format (e.g., example@domain.com)';
    }
    return null;
  }

  // Kiểm tra độ mạnh của Mật khẩu
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long'; // Ít nhất 8 ký tự
    }
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Password must contain at least 1 digit'; // Ít nhất 1 số
    }
    return null;
  }

  // Kiểm tra mật khẩu nhập lại có khớp nhau không
  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Confirm password is required';
    }
    if (value != _password) {
      return 'Passwords do not match'; // Báo lỗi nếu không khớp
    }
    return null;
  }

  // ============================================================================
  // LOGIC SUBMIT & ASYNC EMAIL VALIDATION (LAB 7.4)
  // ============================================================================
  Future<void> _submitForm() async {
    // A. Kích hoạt kiểm tra đồng bộ toàn bộ form tại chỗ
    if (!_formKey.currentState!.validate()) return; // Nếu lỗi cục bộ thì dừng

    // B. Kiểm tra bổ sung điều khoản bắt buộc (Bonus Task)
    if (!_acceptTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('You must accept the Terms & Conditions to proceed.'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    // C. Lưu dữ liệu từ form vào các biến state
    _formKey.currentState!.save();

    // D. Kích hoạt trạng thái kiểm tra Email bất đồng bộ (Giả lập gọi API)
    setState(() {
      _isCheckingEmail = true;
    });

    // Mô phỏng độ trễ mạng Internet mất 2 giây
    await Future.delayed(const Duration(seconds: 2));

    // Quy tắc kiểm tra email đã tồn tại: Email bắt đầu bằng chữ "taken"
    if (_email.trim().toLowerCase().startsWith('taken')) {
      setState(() {
        _isCheckingEmail = false; // Tắt trạng thái loading
      });

      // Hiển thị hộp thoại cảnh báo Email đã bị đăng ký
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Row(
            children: [
              Icon(Icons.error, color: Colors.red),
              SizedBox(width: 8),
              Text('Registration Failed'),
            ],
          ),
          content: Text('The email "$_email" is already taken. Please try another one.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    // E. Xử lý thành công hoàn toàn (Form hợp lệ và Email khả dụng)
    setState(() {
      _isCheckingEmail = false;
    });

    if (!mounted) return;
    // Hiển thị thông báo SnackBar chúc mừng thành công
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Registration Successful! Welcome, $_fullName.'),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 3),
      ),
    );

    // Xóa trắng form sau khi hoàn thành
    _formKey.currentState!.reset();
    setState(() {
      _acceptTerms = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Bọc GestureDetector ở gốc để ẩn bàn phím khi bấm ra vùng trống
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Signup Form'), // AppBar tiêu đề bài Lab
          centerTitle: true,
          backgroundColor: Colors.teal.shade100,
        ),
        // Bọc trong SingleChildScrollView để chống lỗi tràn màn hình khi bật bàn phím ảo
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey, // Gán GlobalKey quản lý trạng thái form
            // Cơ chế tự động bắt lỗi ngay khi người dùng thao tác nhập liệu
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Create an Account',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.teal),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),

                // --- 1. FIELD: HỌ VÀ TÊN ---
                TextFormField(
                  focusNode: _nameFocusNode, // Định vị node focus
                  textInputAction: TextInputAction.next, // Phím hành động tiếp theo trên phím
                  decoration: const InputDecoration(
                    labelText: 'Full Name',
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                  ),
                  validator: _validateFullName, // Gán hàm kiểm tra lỗi cục bộ
                  onFieldSubmitted: (_) {
                    // Chuyển focus tự động sang ô Email [cite: 424]
                    FocusScope.of(context).requestFocus(_emailFocusNode);
                  },
                  onSaved: (value) => _fullName = value ?? '',
                ),
                const SizedBox(height: 16),

                // --- 2. FIELD: EMAIL ---
                TextFormField(
                  focusNode: _emailFocusNode,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText: 'Email Address',
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(),
                    helperText: 'Emails starting with "taken" will trigger async error',
                  ),
                  validator: _validateEmail,
                  onFieldSubmitted: (_) {
                    // Chuyển focus tự động sang ô Mật khẩu
                    FocusScope.of(context).requestFocus(_passwordFocusNode);
                  },
                  onSaved: (value) => _email = value ?? '',
                ),
                const SizedBox(height: 16),

                // --- 3. FIELD: MẬT KHẨU CHÍNH ---
                TextFormField(
                  focusNode: _passwordFocusNode,
                  obscureText: _obscurePassword, // Điểu khiển ẩn hiện chuỗi ký tự
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: const Icon(Icons.lock),
                    // Thêm nút Icon điều khiển ẩn hiện mật khẩu (Bonus Task)
                    suffixIcon: IconButton(
                      icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
                      onPressed: () {
                        setState(() => _obscurePassword = !_obscurePassword);
                      },
                    ),
                    border: const OutlineInputBorder(),
                  ),
                  validator: _validatePassword,
                  onChanged: (value) => _password = value, // Cập nhật trực tiếp để đối chiếu mật khẩu xác nhận
                  onFieldSubmitted: (_) {
                    // Chuyển focus tự động sang ô Xác nhận mật khẩu
                    FocusScope.of(context).requestFocus(_confirmPasswordFocusNode);
                  },
                ),
                const SizedBox(height: 16),

                // --- 4. FIELD: XÁC NHẬN MẬT KHẨU ---
                TextFormField(
                  focusNode: _confirmPasswordFocusNode,
                  obscureText: _obscureConfirmPassword,
                  textInputAction: TextInputAction.done, // Ô cuối cùng cấu hình phím DONE trên bàn phím
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    prefixIcon: const Icon(Icons.lock_clock),
                    suffixIcon: IconButton(
                      icon: Icon(_obscureConfirmPassword ? Icons.visibility_off : Icons.visibility),
                      onPressed: () {
                        setState(() => _obscureConfirmPassword = !_obscureConfirmPassword);
                      },
                    ),
                    border: const OutlineInputBorder(),
                  ),
                  validator: _validateConfirmPassword,
                  onFieldSubmitted: (_) {
                    // Khi ấn Done từ bàn phím, tự động kích hoạt submit form
                    if (!_isCheckingEmail) _submitForm();
                  },
                  onSaved: (value) => _confirmPassword = value ?? '',
                ),
                const SizedBox(height: 12),

                // --- BONUS TASK: CHECKBOX ĐỒNG Ý ĐIỀU KHOẢN ---
                CheckboxListTile(
                  title: const Text(
                    'I accept the Terms & Conditions and Privacy Policy',
                    style: TextStyle(fontSize: 14),
                  ),
                  value: _acceptTerms,
                  onChanged: (bool? value) {
                    setState(() {
                      _acceptTerms = value ?? false;
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                  contentPadding: EdgeInsets.zero,
                ),
                const SizedBox(height: 16),

                // --- BUTTON SUBMIT CHUYỂN ĐỔI TRẠNG THÁI (UX FEEDBACK) ---
                ElevatedButton(
                  // Vô hiệu hóa nút bấm hoàn toàn khi hệ thống đang bận gọi API check email
                  onPressed: _isCheckingEmail ? null : _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  // Đổi hiển thị sang vòng quay Loading nếu đang chạy bất đồng bộ (Bonus Task)
                  child: _isCheckingEmail
                      ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.teal,
                    ),
                  )
                      : const Text('Sign Up', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}