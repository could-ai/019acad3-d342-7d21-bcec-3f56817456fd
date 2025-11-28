import 'message.dart';

class ChatSession {
  final String id;
  final String title;
  final DateTime lastActive;
  final String previewText;
  final List<ChatMessage> messages;

  ChatSession({
    required this.id,
    required this.title,
    required this.lastActive,
    required this.previewText,
    required this.messages,
  });
}
