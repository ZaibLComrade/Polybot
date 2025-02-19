import 'package:flutter/material.dart';
import 'package:polybot/models/message.dart';
import 'package:polybot/widgets/chat/message_bubble.dart';

class ChatMessages extends StatelessWidget {
  final List<Message> messages;

  const ChatMessages({
    super.key,
    required this.messages,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      reverse: false,
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: messages.length,
      itemBuilder: (context, index) {
        return MessageBubble(
          message: messages[messages.length - 1 - index],
        );
      },
    );
  }
}