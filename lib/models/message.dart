class Message {
  final int? id;
  final int sessionId;
  final int userId;
  final String text;
  final bool isUser;
  final DateTime timestamp;
  final String syncStatus;

  Message({
    this.id,
    required this.sessionId,
    required this.userId,
    required this.text,
    required this.isUser,
    DateTime? timestamp,
    this.syncStatus = 'pending',
  }) : timestamp = timestamp ?? DateTime.now();

  Message copyWith({
    int? id,
    int? sessionId,
    int? userId,
    String? text,
    bool? isUser,
    DateTime? timestamp,
    String? syncStatus,
  }) {
    return Message(
      id: id ?? this.id,
      sessionId: sessionId ?? this.sessionId,
      userId: userId ?? this.userId,
      text: text ?? this.text,
      isUser: isUser ?? this.isUser,
      timestamp: timestamp ?? this.timestamp,
      syncStatus: syncStatus ?? this.syncStatus,
    );
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      id: map['id'] as int?,
      sessionId: map['session_id'] as int,
      userId: map['user_id'] as int,
      text: map['message'] as String,
      isUser: map['is_user'] == 1,
      timestamp: DateTime.parse(map['timestamp']),
      syncStatus: map['sync_status'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'session_id': sessionId,
      'user_id': userId,
      'message': text,
      'is_user': isUser ? 1 : 0,
      'timestamp': timestamp.toIso8601String(),
      'sync_status': syncStatus,
    };
  }
}