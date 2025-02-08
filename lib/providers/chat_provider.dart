import 'package:flutter/material.dart';
import 'package:polybot/helper/database_helper.dart';
import 'package:polybot/models/chat_session.dart';
import 'package:polybot/models/message.dart';
import 'package:polybot/services/api_service.dart';

class ChatProvider with ChangeNotifier {
  final DatabaseHelper _db = DatabaseHelper();
  final ApiService _apiService = ApiService();
  
  List<Message> _messages = [];
  List<ChatSession> _sessions = [];
  ChatSession? _currentSession;
  bool _isTyping = false;

  List<Message> get messages => List.unmodifiable(_messages);
  List<ChatSession> get sessions => List.unmodifiable(_sessions);
  ChatSession? get currentSession => _currentSession;
  bool get isTyping => _isTyping;

  Future<void> loadSessions(int userId) async {
    final sessionsList = await _db.getUserChatSessions(userId);
    _sessions = sessionsList.map((s) => ChatSession.fromMap(s)).toList();
    notifyListeners();
  }

  Future<void> createNewSession(int userId, int modelId, String title) async {
    final sessionId = await _db.createChatSession(userId, modelId, title);
    await loadSessions(userId);
    await setCurrentSession(sessionId);
  }

  Future<void> setCurrentSession(int sessionId) async {
    _currentSession = _sessions.firstWhere((s) => s.id == sessionId);
    await loadSessionMessages(sessionId);
    notifyListeners();
  }

  Future<void> loadSessionMessages(int sessionId) async {
    final messagesList = await _db.getSessionMessages(sessionId);
    _messages = messagesList.map((m) => Message.fromMap(m)).toList();
    notifyListeners();
  }

  Future<void> sendMessage(String text, int userId) async {
    if (_currentSession == null) return;

    final message = Message(
      sessionId: _currentSession!.id,
      userId: userId,
      text: text,
      isUser: true,
    );

    // Save user message
    await _db.saveMessage(
      sessionId: message.sessionId,
      userId: message.userId,
      isUser: message.isUser,
      message: message.text,
    );

    // Add to local messages
    _messages.add(message);
    notifyListeners();

    // Generate AI response
    setTyping(true);
    try {
      final response = await _apiService.generateResponse(
        text,
        _currentSession!.modelName,
      );

      final aiMessage = Message(
        sessionId: _currentSession!.id,
        userId: userId,
        text: response,
        isUser: false,
      );

      // Save AI response
      await _db.saveMessage(
        sessionId: aiMessage.sessionId,
        userId: aiMessage.userId,
        isUser: aiMessage.isUser,
        message: aiMessage.text,
      );

      // Add to local messages
      _messages.add(aiMessage);
    } catch (e) {
      print('Error generating response: $e');
    } finally {
      setTyping(false);
    }
  }

  void setTyping(bool typing) {
    _isTyping = typing;
    notifyListeners();
  }

  void clearCurrentChat() {
    _messages.clear();
    _currentSession = null;
    notifyListeners();
  }
}