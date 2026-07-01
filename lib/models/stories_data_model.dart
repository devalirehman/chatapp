class StoryModel {
  final String name;
  final String avatarUrl;
  final bool isMe;
  const StoryModel({
    required this.name,
    required this.avatarUrl,
    this.isMe = false
  });
}

class ChatModel {
  final String name;
  final String message;
  final String time;
  final String avatarUrl;
  final int unreadCount;
  final bool isOnline;
  const ChatModel({
    required this.name,
    required this.message,
    required this.time,
    required this.avatarUrl,
    this.unreadCount = 0,
    this.isOnline = false,
  });
}