import 'package:flutter/material.dart';
import '../models/message.dart';

class AgentChatScreen extends StatefulWidget {
  const AgentChatScreen({super.key});

  @override
  State<AgentChatScreen> createState() => _AgentChatScreenState();
}

class _AgentChatScreenState extends State<AgentChatScreen> {
  final TextEditingController _textController = TextEditingController();
  final List<ChatMessage> _messages = [];
  final ScrollController _scrollController = ScrollController();
  bool _isTyping = false;

  @override
  void initState() {
    super.initState();
    // Add initial greeting
    _messages.add(
      ChatMessage(
        text: "你好！我是你的智能助手 Agent。有什么我可以帮你的吗？",
        isUser: false,
        timestamp: DateTime.now(),
      ),
    );
  }

  void _handleSubmitted(String text) {
    if (text.trim().isEmpty) return;

    _textController.clear();
    setState(() {
      _messages.add(
        ChatMessage(
          text: text,
          isUser: true,
          timestamp: DateTime.now(),
        ),
      );
      _isTyping = true;
    });
    _scrollToBottom();

    // Simulate Agent response
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _messages.add(
            ChatMessage(
              text: "我收到了你的消息：\"$text\"。\n\n这是一个模拟的 Agent 回复。在实际应用中，你可以将这里连接到 LLM API (如 OpenAI, Gemini 等)。",
              isUser: false,
              timestamp: DateTime.now(),
            ),
            _isTyping = false;
          );
        });
        _scrollToBottom();
      }
    });
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Widget _buildMessage(ChatMessage message) {
    final isUser = message.isUser;
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        padding: const EdgeInsets.all(12),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          color: isUser ? Theme.of(context).colorScheme.primary : Colors.grey[200],
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(12),
            topRight: const Radius.circular(12),
            bottomLeft: isUser ? const Radius.circular(12) : Radius.zero,
            bottomRight: isUser ? Radius.zero : const Radius.circular(12),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message.text,
              style: TextStyle(
                color: isUser ? Colors.white : Colors.black87,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "${message.timestamp.hour}:${message.timestamp.minute.toString().padLeft(2, '0')}",
              style: TextStyle(
                color: isUser ? Colors.white70 : Colors.black54,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('智能助手 Agent'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(8),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _buildMessage(_messages[index]);
              },
            ),
          ),
          if (_isTyping)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: LinearProgressIndicator(),
            ),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, -2),
                  blurRadius: 4,
                  color: Colors.black.withOpacity(0.1),
                ),
              ],
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _textController,
                        decoration: const InputDecoration(
                          hintText: '输入消息...',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 16),
                        ),
                        onSubmitted: _handleSubmitted,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.send),
                      color: Theme.of(context).colorScheme.primary,
                      onPressed: () => _handleSubmitted(_textController.text),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
