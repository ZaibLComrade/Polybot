import 'package:flutter/material.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isSmallScreen;
  final VoidCallback onMenuPressed;
  final VoidCallback onModelSelect;
  final VoidCallback onProfilePressed;

  const ChatAppBar({
    super.key,
    required this.isSmallScreen,
    required this.onMenuPressed,
    required this.onModelSelect,
    required this.onProfilePressed,
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
        IconButton(
          icon: const Icon(Icons.person),
          onPressed: onProfilePressed,
          tooltip: 'View Profile',
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}