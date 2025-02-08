class AiModel {
  final int id;
  final String name;
  final String description;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  // New fields for API integration
  final String apiKey;
  final String apiProvider;   // e.g., 'OpenAI', 'Anthropic', 'Replicate'
  final String apiEndpoint;
  final String modelId;       // Model-specific identifier (e.g., 'gpt-4', 'claude-2')
  
  // Optional settings for customization
  final double costPerToken;
  final int maxTokens;
  final double temperature;
  final int maxResponseLength;

  AiModel({
    required this.id,
    required this.name,
    required this.description,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    required this.apiKey,
    required this.apiProvider,
    required this.apiEndpoint,
    required this.modelId,
    this.costPerToken = 0.0,
    this.maxTokens = 1000,
    this.temperature = 0.7,
    this.maxResponseLength = 500,
  });

  factory AiModel.fromMap(Map<String, dynamic> map) {
    return AiModel(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      isActive: map['is_active'] == 1,
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
      apiKey: map['api_key'],
      apiProvider: map['api_provider'],
      apiEndpoint: map['api_endpoint'],
      modelId: map['model_id'],
      costPerToken: map['cost_per_token']?.toDouble() ?? 0.0,
      maxTokens: map['max_tokens'] ?? 1000,
      temperature: map['temperature']?.toDouble() ?? 0.7,
      maxResponseLength: map['max_response_length'] ?? 500,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'is_active': isActive ? 1 : 0,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'api_key': apiKey,
      'api_provider': apiProvider,
      'api_endpoint': apiEndpoint,
      'model_id': modelId,
      'cost_per_token': costPerToken,
      'max_tokens': maxTokens,
      'temperature': temperature,
      'max_response_length': maxResponseLength,
    };
  }
}
