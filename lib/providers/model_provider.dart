import 'package:flutter/material.dart';
import 'package:polybot/models/ai_model.dart';

class ModelProvider with ChangeNotifier {
  List<AiModel> _models = [];
  AiModel? _selectedModel;

  List<AiModel> get models => List.unmodifiable(_models);
  List<AiModel> get activeModels => _models.where((m) => m.isActive).toList();
  AiModel? get selectedModel => _selectedModel;

  ModelProvider() {
    _initializeDefaultModels();
  }

  void _initializeDefaultModels() {
    _models = [
      AiModel(
        id: 1,
        name: 'GPT-4',
        description: 'Most capable GPT model for complex tasks',
        isActive: true,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        apiKey:
            const String.fromEnvironment('OPENAI_API_KEY', defaultValue: ''),
        apiProvider: 'OpenAI',
        apiEndpoint: 'https://api.openai.com/v1/chat/completions',
        modelId: 'gpt-4',
        costPerToken: 0.03,
        maxTokens: 8000,
      ),
      AiModel(
        id: 2,
        name: 'GPT-3.5',
        description: 'Fast and efficient for most tasks',
        isActive: true,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        apiKey:
            const String.fromEnvironment('OPENAI_API_KEY', defaultValue: ''),
        apiProvider: 'OpenAI',
        apiEndpoint: 'https://api.openai.com/v1/chat/completions',
        modelId: 'gpt-3.5-turbo',
        costPerToken: 0.002,
        maxTokens: 4000,
      ),
      AiModel(
        id: 3,
        name: 'Claude AI',
        description: 'Anthropic\'s advanced AI model',
        isActive: true,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        apiKey:
            const String.fromEnvironment('ANTHROPIC_API_KEY', defaultValue: ''),
        apiProvider: 'Anthropic',
        apiEndpoint: 'https://api.anthropic.com/v1/messages',
        modelId: 'claude-2',
        costPerToken: 0.01,
        maxTokens: 100000,
      ),
      AiModel(
        id: 2,
        name: 'DeepSeek',
        description:
            'Advanced model specializing in data-driven insights and analysis',
        isActive: true,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        apiKey:
            const String.fromEnvironment('DEEPSEEK_API_KEY', defaultValue: ''),
        apiProvider: 'DeepSeek',
        apiEndpoint:
            'https://api.deepseek.com/v1/chat/completions', // Replace with actual DeepSeek endpoint
        modelId: 'deepseek-llm', // Replace with actual model ID if available
        costPerToken:
            0.025, // Hypothetical pricing; adjust based on actual rates
        maxTokens: 6000,
        temperature: 0.7,
        maxResponseLength: 1000,
      ),
      AiModel(
        id: 3,
        name: 'Gemini Flash',
        description:
            'High-speed model for fast, efficient responses from Google AI',
        isActive: true,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        apiKey:
            const String.fromEnvironment('GEMINI_API_KEY', defaultValue: ''),
        apiProvider: 'Google AI',
        apiEndpoint:
            'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent',
        modelId: 'gemini-1.5-flash',
        costPerToken:
            0.02, // Hypothetical pricing; adjust based on actual rates
        maxTokens: 4000,
        temperature: 0.7,
        maxResponseLength: 800,
      ),
    ];

    if (_selectedModel == null && _models.isNotEmpty) {
      _selectedModel = _models.first;
    }
  }

  void selectModel(AiModel model) {
    _selectedModel = model;
    notifyListeners();
  }

  void addModel(AiModel model) {
    _models.add(model);
    notifyListeners();
  }

  void updateModel(AiModel model) {
    final index = _models.indexWhere((m) => m.id == model.id);
    if (index != -1) {
      _models[index] = model;
      notifyListeners();
    }
  }

  void toggleModelStatus(int modelId) {
    final index = _models.indexWhere((m) => m.id == modelId);
    if (index != -1) {
      final model = _models[index];
      _models[index] = AiModel(
        id: model.id,
        name: model.name,
        description: model.description,
        isActive: !model.isActive,
        createdAt: model.createdAt,
        updatedAt: DateTime.now(),
        apiKey: model.apiKey,
        apiProvider: model.apiProvider,
        apiEndpoint: model.apiEndpoint,
        modelId: model.modelId,
        costPerToken: model.costPerToken,
        maxTokens: model.maxTokens,
        temperature: model.temperature,
        maxResponseLength: model.maxResponseLength,
      );
      notifyListeners();
    }
  }
}
