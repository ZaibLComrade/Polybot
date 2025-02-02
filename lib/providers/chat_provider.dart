import 'package:flutter/material.dart';
import 'package:polybot/models/message.dart';

class ChatProvider with ChangeNotifier {
  final List<Message> _messages = [];
  bool _isTyping = false;
  String _selectedModel = 'GPT-4';

  List<Message> get messages => List.unmodifiable(_messages);
  bool get isTyping => _isTyping;
  String get selectedModel => _selectedModel;

  void addMessage(Message message) {
    _messages.insert(0, message);
    notifyListeners();
    
    if (message.isUser) {
      _simulateResponse();
    }
  }

  void setTyping(bool typing) {
    _isTyping = typing;
    notifyListeners();
  }

  void setModel(String model) {
    _selectedModel = model;
    notifyListeners();
  }

  void _simulateResponse() {
    setTyping(true);
    
    Future.delayed(const Duration(seconds: 2), () {
      addMessage(
        Message(
          text: "This is a simulated response from $_selectedModel.",
          isUser: false,
        ),
      );
      setTyping(false);
    });
  }

  void clearChat() {
    _messages.clear();
    notifyListeners();
  }
}