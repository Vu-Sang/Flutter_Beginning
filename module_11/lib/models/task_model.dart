class Task {
  final String id;
  String title;
  bool isCompleted;

  Task({
    required this.id,
    required this.title,
    this.isCompleted = false,
  });

  // Thay đổi trạng thái true <-> false
  void toggle() {
    isCompleted = !isCompleted;
  }
}