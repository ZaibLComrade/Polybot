import 'package:flutter/material.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(title: const Text('Chats'), automaticallyImplyLeading: false),
          Expanded(
            child: ListView(
              children: List.generate(5, (index) => ListTile(title: Text('Chat $index'))),
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Models', style: TextStyle(fontWeight: FontWeight.bold)),
                ListTile(title: const Text('GPT-4')), 
                ListTile(title: const Text('GPT-3.5')), 
                ListTile(title: const Text('Claude AI')), 
                ListTile(title: const Text('Llama 2')), 
              ],
            ),
          ),
        ],
      ),
    );
  }
}