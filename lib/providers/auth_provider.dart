import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  bool _isAuthenticated = false;
  String? _email;
  String? _displayName;

  bool get isAuthenticated => _isAuthenticated;
  String? get email => _email;
  String? get displayName => _displayName;

  void signIn(String email, String password) {
    // Simulate authentication
    _isAuthenticated = true;
    _email = email;
    _displayName = email.split('@')[0];
    notifyListeners();
  }

  void signOut() {
    _isAuthenticated = false;
    _email = null;
    _displayName = null;
    notifyListeners();
  }

  void updateProfile({String? displayName}) {
    _displayName = displayName ?? _displayName;
    notifyListeners();
  }
}