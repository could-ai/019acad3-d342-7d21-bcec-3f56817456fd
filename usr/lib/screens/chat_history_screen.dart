import 'package:flutter/material.dart';
import '../models/chat_session.dart';
import '../models/message.dart';
import 'agent_chat_screen.dart';

class ChatHistoryScreen extends StatelessWidget {
  const ChatHistoryScreen({super.key});

  // Mock data for demonstration
  List<ChatSession> _getMockSessions() {
    return [
      ChatSession(
        id: '1',
        title: 'Flutter 开发助手',
        lastActive: DateTime.now().subtract(const Duration(hours: 2)),
        previewText: 'StatefulWidget 和 StatelessWidget 的主要区别在于状态管理...',
        messages: [
          ChatMessage(
            text: "你好，我想了解 Flutter 的基础知识。",
            isUser: true,
            timestamp: DateTime.now().subtract(const Duration(hours: 2, minutes: 10)),
          ),
          ChatMessage(
            text: "你好！Flutter 是 Google 开发的 UI 工具包。你想了解哪方面？",
            isUser: false,
            timestamp: DateTime.now().subtract(const Duration(hours: 2, minutes: 9)),
          ),
          ChatMessage(
            text: "StatefulWidget 和 StatelessWidget 有什么区别？",
            isUser: true,
            timestamp: DateTime.now().subtract(const Duration(hours: 2, minutes: 5)),
          ),
          ChatMessage(
            text: "StatefulWidget 和 StatelessWidget 的主要区别在于状态管理。StatelessWidget 是不可变的，一旦构建就不能改变；而 StatefulWidget 持有状态对象，可以在运行时通过 setState 更新 UI。",
            isUser: false,
            timestamp: DateTime.now().subtract(const Duration(hours: 2)),
          ),
        ],
      ),
      ChatSession(
        id: '2',
        title: 'Python 脚本优化',
        lastActive: DateTime.now().subtract(const Duration(days: 1)),
        previewText: '你可以使用 list comprehension 来简化这段代码。',
        messages: [
          ChatMessage(
            text: "帮我看下这段 Python 代码怎么优化。",
            isUser: true,
            timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 1)),
          ),
          ChatMessage(
            text: "没问题，请发送代码。",
            isUser: false,
            timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 1)),
          ),
          ChatMessage(
            text: "你可以使用 list comprehension 来简化这段代码，使其更具可读性且运行更快。",
            isUser: false,
            timestamp: DateTime.now().subtract(const Duration(days: 1)),
          ),
        ],
      ),
      ChatSession(
        id: '3',
        title: '旅行计划 - 日本',
        lastActive: DateTime.now().subtract(const Duration(days: 3)),
        previewText: '东京塔和浅草寺是必去的景点...',
        messages: [
          ChatMessage(
            text: "给我一个东京 3 日游的计划。",
            isUser: true,
            timestamp: DateTime.now().subtract(const Duration(days: 3, hours: 5)),
          ),
          ChatMessage(
            text: "好的，这是为您准备的东京 3 日游简要行程：\nDay 1: 浅草寺 & 晴空塔\nDay 2: 涩谷 & 原宿\nDay 3: 新宿 & 明治神宫",
            isUser: false,
            timestamp: DateTime.now().subtract(const Duration(days: 3, hours: 4)),
          ),
        ],
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final sessions = _getMockSessions();

    return Scaffold(
      appBar: AppBar(
        title: const Text('会话历史'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView.builder(
        itemCount: sessions.length,
        padding: const EdgeInsets.all(8),
        itemBuilder: (context, index) {
          final session = sessions[index];
          return Card(
            elevation: 2,
            margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AgentChatScreen(
                      initialMessages: session.messages,
                      chatTitle: session.title,
                    ),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            session.title,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          _formatDate(session.lastActive),
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      session.previewText,
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 14,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Icon(
                          Icons.chat_bubble_outline,
                          size: 16,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${session.messages.length} 条消息',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 12,
                          ),
                        ),
                        const Spacer(),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 14,
                          color: Colors.grey[400],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return "${date.hour}:${date.minute.toString().padLeft(2, '0')}";
    } else if (difference.inDays < 7) {
      return "${difference.inDays} 天前";
    } else {
      return "${date.year}-${date.month}-${date.day}";
    }
  }
}
