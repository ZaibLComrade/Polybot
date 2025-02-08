class User {
  final int id;
  final String username;
  final String email;
  final String role;
  final DateTime createdAt;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.role,
    required this.createdAt,
  });

  User copyWith({
    int? id,
    String? username,
    String? email,
    String? role,
    DateTime? createdAt,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      role: role ?? this.role,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as int,
      username: map['username'] as String,
      email: map['email'] as String,
      role: map['role'] as String,
      createdAt: DateTime.parse(map['created_at']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'role': role,
      'created_at': createdAt.toIso8601String(),
    };
  }

  bool get isAdmin => role == 'admin';
  bool get isUser => role == 'user';
}