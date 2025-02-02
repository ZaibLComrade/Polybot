import 'package:flutter/material.dart';
import 'package:polybot/pages/chat_page.dart';
import 'package:polybot/pages/landing_page.dart';
import 'package:polybot/pages/login_page.dart';
import 'package:polybot/pages/pricing_page.dart';
import 'package:polybot/pages/user_page.dart';
import 'package:polybot/themes/app_theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ super.key });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Polybot",
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      showSemanticsDebugger: false,
      initialRoute: "/",
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const LandingPage(),
        '/login': (context) => const LoginPage(),
        '/chat': (context) => const ChatPage(),
        '/pricing': (context) => const PricingPage(),
        '/profile': (context) => const UserPage(),
      },
    );
  }
}