import 'package:flutter/material.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.secondary,
                  ],
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Theme.of(context).colorScheme.surface,
                    child: Icon(
                      Icons.person,
                      size: 50,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'John Doe',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                  ),
                  Text(
                    'john.doe@example.com',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context)
                              .colorScheme
                              .onPrimary
                              .withValues(alpha: 0.8),
                        ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSection(
                    context,
                    'Account Settings',
                    [
                      _buildTile(
                        context,
                        Icons.edit,
                        'Edit Profile',
                        'Update your personal information',
                        onTap: () {
                          Navigator.pushNamed(context, "/profile/edit-profile");
                        },
                      ),
                      _buildTile(
                        context,
                        Icons.lock,
                        'Change Password',
                        'Update your security credentials',
                        onTap: () {
                          Navigator.pushNamed(
                              context, "/profile/change-password");
                        },
                      ),
                      _buildTile(
                        context,
                        Icons.notifications,
                        'Notifications',
                        'Manage your notification preferences',
                        onTap: () {
                          Navigator.pushNamed(context, "/profile/notification");
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  _buildSection(
                    context,
                    'Chat Settings',
                    [
                      _buildTile(
                        context,
                        Icons.chat_bubble,
                        'Chat History',
                        'View your conversation history',
                        onTap: () {
                          Navigator.pushNamed(context, "/history");
                        },
                      ),
                      _buildTile(
                        context,
                        Icons.model_training,
                        'AI Models',
                        'Manage your preferred AI models',
                        onTap: () {
                          Navigator.pushNamed(context, "/models");
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  _buildSection(
                    context,
                    'Support',
                    [
                      _buildTile(
                        context,
                        Icons.help,
                        'Help Center',
                        'Get help with using the app',
                        onTap: () {},
                      ),
                      _buildTile(
                        context,
                        Icons.privacy_tip,
                        'Privacy Policy',
                        'Read our privacy policy',
                        onTap: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(
    BuildContext context,
    String title,
    List<Widget> children,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        Card(
          margin: EdgeInsets.zero,
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }

  Widget _buildTile(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle, {
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
