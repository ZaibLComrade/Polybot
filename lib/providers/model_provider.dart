import 'package:flutter/material.dart';
import 'package:polybot/helper/database_helper.dart';
import 'package:polybot/models/ai_model.dart';

class ModelProvider with ChangeNotifier {
  final DatabaseHelper _db = DatabaseHelper();
  List<AiModel> _models = [];
  AiModel? _selectedModel;

  List<AiModel> get models => List.unmodifiable(_models);
  List<AiModel> get activeModels => _models.where((m) => m.isActive).toList();
  AiModel? get selectedModel => _selectedModel;

  Future<void> loadModels() async {
    final modelsList = await _db.getActiveAiModels();
    _models = modelsList.map((m) => AiModel.fromMap(m)).toList();
    
    if (_models.isNotEmpty && _selectedModel == null) {
      _selectedModel = _models.first;
    }
    
    notifyListeners();
  }

  Future<bool> addModel(String name, String description, String apiKey) async {
    final success = await _db.addAiModel(name, description, apiKey);
    if (success) {
      await loadModels();
    }
    return success;
  }

  void selectModel(AiModel model) {
    _selectedModel = model;
    notifyListeners();
  }

  Future<void> toggleModelStatus(int modelId) async {
    final model = _models.firstWhere((m) => m.id == modelId);
    final updatedModel = AiModel(
      id: model.id,
      name: model.name,
      description: model.description,
      isActive: !model.isActive,
      createdAt: model.createdAt,
      updatedAt: DateTime.now(),
    );

    await _db.updateModel(updatedModel);
    await loadModels();
  }

  Future<void> updateModel(AiModel model) async {
    await _db.updateModel(model);
    await loadModels();
  }

  Future<void> deleteModel(int modelId) async {
    await _db.deleteModel(modelId);
    if (_selectedModel?.id == modelId) {
      _selectedModel = null;
    }
    await loadModels();
  }
}