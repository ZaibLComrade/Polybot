import 'package:flutter/material.dart';
import 'package:polybot/pages/chat_page.dart';
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
        "/": (context) => ChatPage(),
      },
    );
  }
}