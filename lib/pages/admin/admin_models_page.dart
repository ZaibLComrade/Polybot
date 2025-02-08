import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:polybot/models/ai_model.dart';
import 'package:polybot/providers/model_provider.dart';
import 'package:polybot/widgets/common/custom_text_field.dart';

class AdminModelsPage extends StatefulWidget {
  const AdminModelsPage({super.key});

  @override
  State<AdminModelsPage> createState() => _AdminModelsPageState();
}

class _AdminModelsPageState extends State<AdminModelsPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _apiKeyController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _apiKeyController.dispose();
    super.dispose();
  }

  void _showAddModelDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New AI Model'),
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextField(
                controller: _nameController,
                label: 'Model Name',
                hint: 'Enter model name',
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _descriptionController,
                label: 'Description',
                hint: 'Enter model description',
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _apiKeyController,
                label: 'API Key',
                hint: 'Enter API key',
                obscureText: true,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState?.validate() ?? false) {
                context.read<ModelProvider>().addModel(
                      _nameController.text,
                      _descriptionController.text,
                      _apiKeyController.text,
                    );
                Navigator.pop(context);
                _nameController.clear();
                _descriptionController.clear();
                _apiKeyController.clear();
              }
            },
            child: const Text('Add Model'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage AI Models'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _showAddModelDialog,
            tooltip: 'Add New Model',
          ),
        ],
      ),
      body: Consumer<ModelProvider>(
        builder: (context, modelProvider, child) {
          final models = modelProvider.models;
          
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: models.length,
            itemBuilder: (context, index) {
              final model = models[index];
              return _buildModelCard(context, model);
            },
          );
        },
      ),
    );
  }

  Widget _buildModelCard(BuildContext context, AiModel model) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        model.name,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(
                        model.description,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: model.isActive,
                  onChanged: (value) {
                    // Toggle model active status
                    context.read<ModelProvider>().toggleModelStatus(model.id);
                  },
                ),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Created: ${model.createdAt.toString().split('.')[0]}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        // Show edit dialog
                      },
                      tooltip: 'Edit Model',
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        // Show delete confirmation
                      },
                      tooltip: 'Delete Model',
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}