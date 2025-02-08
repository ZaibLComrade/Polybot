import 'package:flutter/material.dart';
import 'package:polybot/models/message.dart';
import 'package:polybot/services/api_service.dart';

class ChatProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<Message> _messages = [];
  bool _isTyping = false;

  List<Message> get messages => List.unmodifiable(_messages);
  bool get isTyping => _isTyping;

  Future<void> sendMessage(String text, String modelName) async {
    if (text.isEmpty) return;

    // Add user message
    final userMessage = Message(
      text: text,
      isUser: true,
    );

    _messages.insert(0, userMessage);
    notifyListeners();

    // Generate AI response
    _isTyping = true;
    notifyListeners();

    try {
      final response = await _apiService.generateResponse(text, modelName);
      
      final aiMessage = Message(
        text: response,
        isUser: false,
      );
      _messages.insert(0, aiMessage);
    } catch (e) {
      final errorMessage = Message(
        text: 'Error: Failed to generate response. Please try again.',
        isUser: false,
      );
      _messages.insert(0, errorMessage);
    } finally {
      _isTyping = false;
      notifyListeners();
    }
  }

  void clearChat() {
    _messages.clear();
    notifyListeners();
  }
}