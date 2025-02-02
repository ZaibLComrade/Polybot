import 'package:flutter/material.dart';
import 'package:polybot/models/message.dart';
import 'package:polybot/widgets/message_bubble.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final List<Message> _messages = [];
  final _textController = TextEditingController();

  void _handleSubmitted(String text) {
    if (text.isEmpty) return;

    setState(() {
      _messages.add(Message(text: text, isUser: true));
      _textController.clear();
    });

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _messages.add(Message(
            text: "I'm an AI assistant. How can I help you today?",
            isUser: false));
      });
    });
  }

  //   @override
  // Widget build(BuildContext context) {
  //   return Padding(
  //     padding: const EdgeInsets.all(8.0),
  //     child: Row(
  //       children: [
  //         Expanded(
  //           child: TextField(
  //             controller: _textController,
  //             decoration: const InputDecoration(
  //               hintText: 'Enter Text ...',
  //               border: OutlineInputBorder(),
  //             ),
  //           ),
  //         ),
  //         IconButton(icon: const Icon(Icons.language), onPressed: () {}),
  //         IconButton(icon: const Icon(Icons.attach_file), onPressed: () {}),
  //         IconButton(icon: const Icon(Icons.image), onPressed: () {}),
  //         IconButton(icon: const Icon(Icons.add), onPressed: () {}),
  //         IconButton(icon: const Icon(Icons.arrow_upward), onPressed: () {}),
  //       ],
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Polybot"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
                  reverse: true,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    return MessageBubble(
                        message: _messages[_messages.length - 1 - index]);
                  })),
          Container(
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 4,
                    offset: const Offset(0, -2),
                  )
                ]),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _textController,
                decoration: InputDecoration(
                  hintText: "Enter message...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                onSubmitted: _handleSubmitted,
              ),
            ),
          ),
          const SizedBox(height: 8),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(child: Text("Hello")),
              FloatingActionButton(
                onPressed: () => _handleSubmitted(_textController.text),
                child: const Icon(Icons.send),
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}
