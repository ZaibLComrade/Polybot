import 'package:flutter/material.dart';

class NotificationSettings extends StatefulWidget {
  const NotificationSettings({super.key});

  @override
  State<NotificationSettings> createState() => _NotificationSettingsState();
}

class _NotificationSettingsState extends State<NotificationSettings> {
  bool _pushNotifications = true;
  bool _emailNotifications = true;
  bool _messageNotifications = true;
  bool _updateNotifications = true;
  bool _marketingNotifications = false;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        _buildSection(
          'General Notifications',
          [
            _buildSwitchTile(
              'Push Notifications',
              'Receive push notifications on your device',
              _pushNotifications,
              (value) => setState(() => _pushNotifications = value),
            ),
            _buildSwitchTile(
              'Email Notifications',
              'Receive email notifications',
              _emailNotifications,
              (value) => setState(() => _emailNotifications = value),
            ),
          ],
        ),
        const SizedBox(height: 24),
        _buildSection(
          'Chat Notifications',
          [
            _buildSwitchTile(
              'Message Notifications',
              'Get notified about new messages',
              _messageNotifications,
              (value) => setState(() => _messageNotifications = value),
            ),
          ],
        ),
        const SizedBox(height: 24),
        _buildSection(
          'Other Notifications',
          [
            _buildSwitchTile(
              'Updates & Features',
              'Get notified about app updates and new features',
              _updateNotifications,
              (value) => setState(() => _updateNotifications = value),
            ),
            _buildSwitchTile(
              'Marketing & Promotions',
              'Receive marketing and promotional emails',
              _marketingNotifications,
              (value) => setState(() => _marketingNotifications = value),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        Card(
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }

  Widget _buildSwitchTile(
    String title,
    String subtitle,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      value: value,
      onChanged: onChanged,
      secondary: Icon(
        Icons.notifications,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}