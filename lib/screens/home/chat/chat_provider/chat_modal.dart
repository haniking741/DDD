// models/chat_model.dart
class Chat {
  final String name;
  final String message;
  final String time;
  final String image;
  final bool isOnline;

  Chat({
    required this.name,
    required this.message,
    required this.time,
    required this.image,
    this.isOnline = false,
  });
}
