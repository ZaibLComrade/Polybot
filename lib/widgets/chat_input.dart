import 'package:flutter/material.dart';

class ChatInput extends StatelessWidget {
  final TextEditingController controller;
  final bool isComposing;
  final Function(String) onSubmitted;
  final Function(String) onChanged;

  const ChatInput({
    super.key,
    required this.controller,
    required this.isComposing,
    required this.onSubmitted,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.attach_file),
              onPressed: () {
                // Handle file attachment
              },
              tooltip: 'Attach File',
            ),
            Expanded(
              child: TextField(
                controller: controller,
                onChanged: onChanged,
                decoration: InputDecoration(
                  hintText: 'Type a message...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                ),
                onSubmitted: onSubmitted,
                maxLines: null,
                textInputAction: TextInputAction.send,
              ),
            ),
            const SizedBox(width: 8),
            FloatingActionButton(
              onPressed: isComposing
                  ? () => onSubmitted(controller.text)
                  : null,
              tooltip: 'Send Message',
              child: Icon(
                Icons.send,
                color: isComposing
                    ? theme.colorScheme.onPrimary
                    : theme.colorScheme.onPrimary.withValues(alpha: 0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}