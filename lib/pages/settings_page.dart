import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:polybot/providers/theme_provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildSection(
            context,
            'Appearance',
            [
              _buildThemeSelector(context),
              _buildLanguageSelector(context),
            ],
          ),
          _buildSection(
            context,
            'Notifications',
            [
              _buildNotificationToggle(
                context,
                'Push Notifications',
                'Receive notifications for new messages',
              ),
              _buildNotificationToggle(
                context,
                'Email Notifications',
                'Receive email updates',
              ),
            ],
          ),
          _buildSection(
            context,
            'Chat',
            [
              _buildChatSetting(
                context,
                'Message History',
                'Keep chat history for 30 days',
              ),
              _buildChatSetting(
                context,
                'Auto-delete Messages',
                'Delete messages after 30 days',
              ),
            ],
          ),
          _buildSection(
            context,
            'Privacy',
            [
              _buildPrivacySetting(
                context,
                'Data Collection',
                'Allow anonymous usage data collection',
              ),
              _buildPrivacySetting(
                context,
                'Third-party Integration',
                'Allow third-party services',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSection(
      BuildContext context, String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        Card(
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }

  Widget _buildThemeSelector(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return ListTile(
      title: const Text('Theme'),
      subtitle: const Text('Choose your preferred theme'),
      trailing: DropdownButton<ThemeMode>(
        value: themeProvider.themeMode,
        onChanged: (ThemeMode? newMode) {
          if (newMode != null) {
            themeProvider.setThemeMode(newMode);
          }
        },
        items: const [
          DropdownMenuItem(
            value: ThemeMode.system,
            child: Text('System'),
          ),
          DropdownMenuItem(
            value: ThemeMode.light,
            child: Text('Light'),
          ),
          DropdownMenuItem(
            value: ThemeMode.dark,
            child: Text('Dark'),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageSelector(BuildContext context) {
    return ListTile(
      title: const Text('Language'),
      subtitle: const Text('Select your preferred language'),
      trailing: DropdownButton<String>(
        value: 'English',
        onChanged: (String? newValue) {
          // Implement language change
        },
        items: const [
          DropdownMenuItem(
            value: 'English',
            child: Text('English'),
          ),
          DropdownMenuItem(
            value: 'Spanish',
            child: Text('Spanish'),
          ),
          DropdownMenuItem(
            value: 'French',
            child: Text('French'),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationToggle(
    BuildContext context,
    String title,
    String subtitle,
  ) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      value: true,
      onChanged: (bool value) {
        // Implement notification toggle
      },
    );
  }

  Widget _buildChatSetting(
    BuildContext context,
    String title,
    String subtitle,
  ) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      value: true,
      onChanged: (bool value) {
        // Implement chat setting toggle
      },
    );
  }

  Widget _buildPrivacySetting(
    BuildContext context,
    String title,
    String subtitle,
  ) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      value: false,
      onChanged: (bool value) {
        // Implement privacy setting toggle
      },
    );
  }
}
