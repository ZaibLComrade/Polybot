import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:polybot/providers/model_provider.dart';

class ModelsPage extends StatelessWidget {
  const ModelsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Models'),
      ),
      body: Consumer<ModelProvider>(
        builder: (context, modelProvider, child) {
          final models = modelProvider.models;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: models.length,
            itemBuilder: (context, index) {
              final model = models[index];
              final isSelected = modelProvider.selectedModel?.id == model.id;

              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            _getModelIcon(model.name),
                            size: 32,
                            color: isSelected
                                ? Theme.of(context).colorScheme.primary
                                : null,
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  model.name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(
                                        color: isSelected
                                            ? Theme.of(context).colorScheme.primary
                                            : null,
                                        fontWeight: isSelected
                                            ? FontWeight.bold
                                            : null,
                                      ),
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
                              modelProvider.toggleModelStatus(model.id);
                            },
                          ),
                        ],
                      ),
                      const Divider(height: 24),
                      _buildModelDetails(context, model),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildModelDetails(BuildContext context, dynamic model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDetailRow(
          context,
          'Cost',
          '\$${model.costPerToken}/1K tokens',
          Icons.attach_money,
        ),
        _buildDetailRow(
          context,
          'Max Tokens',
          model.maxTokens.toString(),
          Icons.data_usage,
        ),
        _buildDetailRow(
          context,
          'Temperature',
          model.temperature.toString(),
          Icons.thermostat,
        ),
        _buildDetailRow(
          context,
          'Max Response',
          '${model.maxResponseLength} tokens',
          Icons.text_fields,
        ),
      ],
    );
  }

  Widget _buildDetailRow(
    BuildContext context,
    String label,
    String value,
    IconData icon,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 8),
          Text(
            '$label:',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(width: 8),
          Text(value, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }

  IconData _getModelIcon(String modelName) {
    switch (modelName) {
      case 'GPT-4':
        return Icons.auto_awesome;
      case 'GPT-3.5':
        return Icons.bolt;
      case 'Claude AI':
        return Icons.psychology;
      default:
        return Icons.smart_toy;
    }
  }
}