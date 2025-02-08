class ChatSession {
  final int id;
  final int userId;
  final int modelId;
  final String title;
  final String modelName;
  final String? lastMessage;
  final DateTime createdAt;

  ChatSession({
    required this.id,
    required this.userId,
    required this.modelId,
    required this.title,
    required this.modelName,
    this.lastMessage,
    required this.createdAt,
  });

  factory ChatSession.fromMap(Map<String, dynamic> map) {
    return ChatSession(
      id: map['id'],
      userId: map['user_id'],
      modelId: map['model_id'],
      title: map['title'],
      modelName: map['model_name'],
      lastMessage: map['last_message'],
      createdAt: DateTime.parse(map['created_at']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'model_id': modelId,
      'title': title,
      'model_name': modelName,
      'last_message': lastMessage,
      'created_at': createdAt.toIso8601String(),
    };
  }
}