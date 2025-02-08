import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:polybot/providers/auth_provider.dart';

class UserAvatarMenu extends StatelessWidget {
  const UserAvatarMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.currentUser;
    final isAdmin = user?.isAdmin ?? false;

    if (user == null) {
      return TextButton(
        onPressed: () => Navigator.pushNamed(context, '/login'),
        child: const Text('Sign In'),
      );
    }

    return PopupMenuButton<String>(
      offset: const Offset(0, 40),
      child: CircleAvatar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        child: Text(
          user.username[0].toUpperCase(),
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 'profile',
          child: ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            contentPadding: EdgeInsets.zero,
          ),
        ),
        PopupMenuItem(
          value: 'settings',
          child: ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            contentPadding: EdgeInsets.zero,
          ),
        ),
        if (isAdmin)
          PopupMenuItem(
            value: 'admin',
            child: ListTile(
              leading: const Icon(Icons.admin_panel_settings),
              title: const Text('Admin Dashboard'),
              contentPadding: EdgeInsets.zero,
            ),
          ),
        const PopupMenuDivider(),
        PopupMenuItem(
          value: 'logout',
          child: ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            contentPadding: EdgeInsets.zero,
          ),
        ),
      ],
      onSelected: (value) async {
        switch (value) {
          case 'profile':
            Navigator.pushNamed(context, '/profile');
            break;
          case 'settings':
            Navigator.pushNamed(context, '/settings');
            break;
          case 'admin':
            Navigator.pushNamed(context, '/admin');
            break;
          case 'logout':
            await authProvider.signOut();
            if (context.mounted) {
              Navigator.pushReplacementNamed(context, '/login');
            }
            break;
        }
      },
    );
  }
}