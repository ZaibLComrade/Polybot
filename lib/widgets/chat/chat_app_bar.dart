import 'package:flutter/material.dart';
import 'package:polybot/widgets/chat/user_avatar_menu.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isSmallScreen;
  final VoidCallback onMenuPressed;
  final VoidCallback onModelSelect;

  const ChatAppBar({
    super.key,
    required this.isSmallScreen,
    required this.onMenuPressed,
    required this.onModelSelect,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Polybot'),
      centerTitle: true,
      leading: isSmallScreen
          ? IconButton(
              icon: const Icon(Icons.menu),
              onPressed: onMenuPressed,
              tooltip: 'Open Menu',
            )
          : null,
      actions: [
        if (isSmallScreen)
          IconButton(
            icon: const Icon(Icons.model_training),
            onPressed: onModelSelect,
            tooltip: 'Select AI Model',
          ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: UserAvatarMenu(),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}