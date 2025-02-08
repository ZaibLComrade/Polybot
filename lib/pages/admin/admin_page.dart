import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "package:polybot/models/ai_model.dart";
import 'package:polybot/providers/model_provider.dart';
import 'package:polybot/widgets/common/custom_text_field.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAddModelSection(),
            const SizedBox(height: 32),
            _buildModelsList(),
          ],
        ),
      ),
    );
  }

  Widget _buildAddModelSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add New AI Model',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Model Name',
                hint: 'Enter model name',
                controller: _nameController,
              ),
              CustomTextField(
                label: 'Description',
                hint: 'Enter model description',
                controller: _descriptionController,
              ),
              CustomTextField(
                label: 'API Key',
                hint: 'Enter API key',
                controller: _apiKeyController,
                obscureText: true,
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _handleAddModel,
                  child: const Text('Add Model'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildModelsList() {
    return Consumer<ModelProvider>(
      builder: (context, modelProvider, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Available Models',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: modelProvider.models.length,
              itemBuilder: (context, index) {
                final model = modelProvider.models[index];
                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.model_training),
                    title: Text(model.name),
                    subtitle: Text(model.description),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => _showEditDialog(model),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => _showDeleteDialog(model),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _handleAddModel() async {
    if (_formKey.currentState?.validate() ?? false) {
      final modelProvider = Provider.of<ModelProvider>(context, listen: false);
      final success = await modelProvider.addModel(
        _nameController.text,
        _descriptionController.text,
        _apiKeyController.text,
      );

      if (success) {
        _nameController.clear();
        _descriptionController.clear();
        _apiKeyController.clear();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Model added successfully')),
          );
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to add model')),
          );
        }
      }
    }
  }

  void _showEditDialog(AiModel model) {
    // Implement edit dialog
  }

  void _showDeleteDialog(AiModel model) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Model'),
        content: Text('Are you sure you want to delete ${model.name}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // Implement delete functionality
              Navigator.pop(context);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}