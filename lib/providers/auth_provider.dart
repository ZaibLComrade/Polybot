import 'package:flutter/material.dart';
import 'package:polybot/helper/database_helper.dart';
import 'package:polybot/models/user.dart';

class AuthProvider with ChangeNotifier {
  bool _isAuthenticated = false;
  User? _currentUser;
  final DatabaseHelper _db = DatabaseHelper();
  
  bool get isAuthenticated => _isAuthenticated;
  User? get currentUser => _currentUser;

  Future<void> checkAuthStatus() async {
    final lastUser = await _db.getLastLoggedInUser();
    if (lastUser != null) {
      _isAuthenticated = true;
      _currentUser = User.fromMap(lastUser);
      notifyListeners();
    }
  }

  Future<bool> signIn(String email, String password) async {
    final user = await _db.loginUser(email, password);
    if (user != null) {
      _isAuthenticated = true;
      _currentUser = User.fromMap(user);
      
      // Save auth session to database
      await _db.saveAuthSession(_currentUser!.id);
      
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<void> signOut() async {
    _isAuthenticated = false;
    _currentUser = null;
    
    // Clear auth sessions from database
    await _db.clearAuthSessions();
    
    notifyListeners();
  }

  Future<void> updateProfile({String? username}) async {
    if (_currentUser != null && username != null) {
      // Update user in database (you'll need to add this method to DatabaseHelper)
      // await _db.updateUser(_currentUser!.id, {'username': username});
      
      _currentUser = _currentUser!.copyWith(username: username);
      notifyListeners();
    }
  }
}