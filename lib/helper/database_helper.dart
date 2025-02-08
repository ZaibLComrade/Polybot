import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'dart:convert';
import "package:polybot/models/ai_model.dart";

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'polybot.db');
    return await openDatabase(
      path,
      version: 2,
      onCreate: _createDb,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _createDb(Database db, int version) async {
    // Users table with role
    await db.execute('''
      CREATE TABLE users(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT UNIQUE,
        email TEXT UNIQUE,
        password TEXT,
        role TEXT DEFAULT 'user',
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP
      )
    ''');

    // AI Models table
    await db.execute('''
      CREATE TABLE ai_models(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT UNIQUE,
        description TEXT,
        api_key TEXT,
        is_active BOOLEAN DEFAULT 1,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
        updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
      )
    ''');

    // Chat Sessions table
    await db.execute('''
      CREATE TABLE chat_sessions(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER,
        model_id INTEGER,
        title TEXT,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY(user_id) REFERENCES users(id),
        FOREIGN KEY(model_id) REFERENCES ai_models(id)
      )
    ''');

    // Messages table with session reference
    await db.execute('''
      CREATE TABLE messages(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        session_id INTEGER,
        user_id INTEGER,
        is_user BOOLEAN,
        message TEXT,
        timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
        sync_status TEXT DEFAULT 'pending',
        FOREIGN KEY(session_id) REFERENCES chat_sessions(id),
        FOREIGN KEY(user_id) REFERENCES users(id)
      )
    ''');

    // Insert default admin user
    final adminPassword = _hashPassword('admin123');
    await db.insert('users', {
      'username': 'admin',
      'email': 'admin@polybot.com',
      'password': adminPassword,
      'role': 'admin'
    });

    // Insert default ChatGPT model
    await db.insert('ai_models', {
      'name': 'ChatGPT',
      'description': 'OpenAI GPT-3.5 model for general conversation',
      'api_key': _encryptApiKey('your-default-api-key'),
      'is_active': 1
    });

    // Add this to the _createDb method
    await db.execute('''
    CREATE TABLE auth_sessions(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      user_id INTEGER,
      created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
      FOREIGN KEY(user_id) REFERENCES users(id)
    )
  ''');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      // Add new columns or tables for version 2
      await db.execute('ALTER TABLE users ADD COLUMN role TEXT DEFAULT "user"');
    }
  }

  // User Authentication Methods
  String _hashPassword(String password) {
    var bytes = utf8.encode(password);
    var digest = sha256.convert(bytes);
    return digest.toString();
  }

  String _encryptApiKey(String apiKey) {
    final key = encrypt.Key.fromSecureRandom(32);
    final iv = encrypt.IV.fromSecureRandom(16);
    final encrypter = encrypt.Encrypter(encrypt.AES(key));
    final encrypted = encrypter.encrypt(apiKey, iv: iv);
    return '${encrypted.base64}|${key.base64}|${iv.base64}';
  }

  String _decryptApiKey(String encryptedData) {
    final parts = encryptedData.split('|');
    final encrypted = encrypt.Encrypted.fromBase64(parts[0]);
    final key = encrypt.Key.fromBase64(parts[1]);
    final iv = encrypt.IV.fromBase64(parts[2]);
    final encrypter = encrypt.Encrypter(encrypt.AES(key));
    return encrypter.decrypt(encrypted, iv: iv);
  }

  // User Management
  Future<Map<String, dynamic>?> loginUser(String email, String password) async {
    final db = await database;
    final hashedPassword = _hashPassword(password);
    final List<Map<String, dynamic>> results = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, hashedPassword],
    );
    return results.isNotEmpty ? results.first : null;
  }

  Future<bool> registerUser(
      String username, String email, String password) async {
    final db = await database;
    try {
      await db.insert('users', {
        'username': username,
        'email': email,
        'password': _hashPassword(password),
        'role': 'user',
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  // AI Model Management
  Future<bool> addAiModel(
      String name, String description, String apiKey) async {
    final db = await database;
    try {
      await db.insert('ai_models', {
        'name': name,
        'description': description,
        'api_key': _encryptApiKey(apiKey),
        'is_active': 1,
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<Map<String, dynamic>>> getActiveAiModels() async {
    final db = await database;
    return await db.query(
      'ai_models',
      where: 'is_active = 1',
      orderBy: 'created_at DESC',
    );
  }

  Future<String?> getApiKey(String modelName) async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db.query(
      'ai_models',
      where: 'name = ? AND is_active = 1',
      whereArgs: [modelName],
    );
    if (results.isEmpty) return null;
    return _decryptApiKey(results.first['api_key']);
  }

  // Chat Session Management
  Future<int> createChatSession(int userId, int modelId, String title) async {
    final db = await database;
    final id = await db.insert('chat_sessions', {
      'user_id': userId,
      'model_id': modelId,
      'title': title,
    });
    return id;
  }

  Future<List<Map<String, dynamic>>> getUserChatSessions(int userId) async {
    final db = await database;
    return await db.rawQuery('''
      SELECT cs.*, am.name as model_name, 
      (SELECT message FROM messages 
       WHERE session_id = cs.id 
       ORDER BY timestamp DESC LIMIT 1) as last_message
      FROM chat_sessions cs
      JOIN ai_models am ON cs.model_id = am.id
      WHERE cs.user_id = ?
      ORDER BY cs.created_at DESC
    ''', [userId]);
  }

  // Message Management
  Future<bool> saveMessage({
    required int sessionId,
    required int userId,
    required bool isUser,
    required String message,
  }) async {
    final db = await database;
    try {
      await db.insert('messages', {
        'session_id': sessionId,
        'user_id': userId,
        'is_user': isUser ? 1 : 0,
        'message': message,
        'sync_status': 'pending',
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<Map<String, dynamic>>> getSessionMessages(int sessionId) async {
    final db = await database;
    return await db.query(
      'messages',
      where: 'session_id = ?',
      whereArgs: [sessionId],
      orderBy: 'timestamp ASC',
    );
  }

  // Sync Management
  Future<List<Map<String, dynamic>>> getPendingSync() async {
    final db = await database;
    return await db.query(
      'messages',
      where: 'sync_status = ?',
      whereArgs: ['pending'],
    );
  }

  Future<void> markAsSynced(int messageId) async {
    final db = await database;
    await db.update(
      'messages',
      {'sync_status': 'synced'},
      where: 'id = ?',
      whereArgs: [messageId],
    );
  }

  Future<void> updateModel(AiModel model) async {
    final db = await database;
    await db.update(
      'ai_models',
      model.toMap(),
      where: 'id = ?',
      whereArgs: [model.id],
    );
  }

  Future<void> deleteModel(int modelId) async {
    final db = await database;
    await db.delete(
      'ai_models',
      where: 'id = ?',
      whereArgs: [modelId],
    );
  }

// Add these methods to the DatabaseHelper class

  Future<Map<String, dynamic>?> getLastLoggedInUser() async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db.query(
      'users',
      where:
          'id = (SELECT user_id FROM auth_sessions ORDER BY created_at DESC LIMIT 1)',
    );
    return results.isNotEmpty ? results.first : null;
  }

  Future<void> saveAuthSession(int userId) async {
    final db = await database;
    await db.insert('auth_sessions', {
      'user_id': userId,
      'created_at': DateTime.now().toIso8601String(),
    });
  }

  Future<void> clearAuthSessions() async {
    final db = await database;
    await db.delete('auth_sessions');
  }
}
