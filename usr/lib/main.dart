import 'package:flutter/material.dart';
import 'screens/agent_chat_screen.dart';
import 'screens/chat_history_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CouldAI User App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MyHomePage(title: 'CouldAI Home'),
        '/agent': (context) => const AgentChatScreen(),
        '/history': (context) => const ChatHistoryScreen(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Icon(
              Icons.smart_toy,
              size: 100,
              color: Colors.deepPurple,
            ),
            const SizedBox(height: 20),
            Text(
              '欢迎使用 CouldAI',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 10),
            const Text(
              '点击下方按钮开始与 Agent 对话',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/agent');
              },
              icon: const Icon(Icons.chat),
              label: const Text('启动新对话'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                textStyle: const TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/history');
              },
              icon: const Icon(Icons.history),
              label: const Text('查看历史会话'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                textStyle: const TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/agent');
        },
        tooltip: 'Chat with Agent',
        child: const Icon(Icons.chat_bubble),
      ),
    );
  }
}
