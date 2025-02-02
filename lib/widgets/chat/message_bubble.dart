import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:polybot/models/message.dart';

class MessageBubble extends StatelessWidget {
  final Message message;

  const MessageBubble({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isUser = message.isUser;

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
            color: isUser
                ? theme.colorScheme.primary
                : theme.colorScheme.secondaryContainer,
            borderRadius: BorderRadius.circular(20).copyWith(
              bottomRight: isUser ? const Radius.circular(0) : null,
              bottomLeft: !isUser ? const Radius.circular(0) : null,
            ),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2))
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message.text,
              style: TextStyle(
                color: isUser
                    ? theme.colorScheme.onPrimary
                    : theme.colorScheme.onSecondaryContainer,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              DateFormat('HH:mm').format(message.timestamp),
              style: TextStyle(
                fontSize: 12,
                color: isUser
                    ? theme.colorScheme.onPrimary.withValues(alpha: 0.7)
                    : theme.colorScheme.onSecondaryContainer
                        .withValues(alpha: 0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
