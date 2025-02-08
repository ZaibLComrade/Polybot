import 'package:flutter/material.dart';
import 'package:polybot/widgets/account/notification_settings.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        centerTitle: true,
      ),
      body: const NotificationSettings(),
    );
  }
}
