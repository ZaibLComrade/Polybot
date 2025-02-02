import 'package:flutter/material.dart';
import 'package:polybot/pages/chat_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ super.key });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Polybot",
      showSemanticsDebugger: false,
      initialRoute: "/",
      debugShowCheckedModeBanner: false,
      routes: {
        "/": (context) => ChatPage(),
      },
    );
  }
}