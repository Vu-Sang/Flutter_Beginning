class Settings {
  final String theme;
  final bool notificationsEnabled;

  // Biến static private đóng vai trò làm bộ nhớ đệm (Cache) lưu thực thể độc nhất
  static Settings? _cacheInstance;

  // Private Constructor chặn việc khởi tạo bừa bãi bằng từ khóa new từ ngoài
  Settings._internal({required this.theme, required this.notificationsEnabled});

  // Factory Constructor kiểm soát và tái sử dụng thực thể cũ (Singleton Pattern)
  factory Settings({String theme = 'light', bool notificationsEnabled = true}) {
    _cacheInstance ??= Settings._internal(
        theme: theme,
        notificationsEnabled: notificationsEnabled
    );
    return _cacheInstance!;
  }
}