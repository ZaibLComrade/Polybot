import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:polybot/providers/chat_provider.dart';
import 'package:polybot/providers/model_provider.dart';
import 'package:polybot/widgets/common/responsive_builder.dart';

class ModelsPage extends StatelessWidget {
  const ModelsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Models'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ResponsiveBuilder(
          mobile: _buildGrid(context, crossAxisCount: 1),
          tablet: _buildGrid(context, crossAxisCount: 2),
          desktop: _buildGrid(context, crossAxisCount: 3),
        ),
      ),
    );
  }

  Widget _buildGrid(BuildContext context, {required int crossAxisCount}) {
    return Consumer2<ModelProvider, ChatProvider>(
      builder: (context, modelProvider, chatProvider, child) {
        final models = modelProvider.activeModels;
        
        if (models.isEmpty) {
          return const Center(
            child: Text('No active models available'),
          );
        }

        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.8,
          ),
          itemCount: models.length,
          itemBuilder: (context, index) {
            final model = models[index];
            final isSelected = modelProvider.selectedModel?.id == model.id;

            return Card(
              elevation: isSelected ? 4 : 1,
              color: isSelected
                  ? Theme.of(context)
                      .colorScheme
                      .primaryContainer
                      .withOpacity(0.3)
                  : null,
              child: InkWell(
                onTap: () {
                  modelProvider.selectModel(model);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Switched to ${model.name}'),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
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
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              model.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                    color: isSelected
                                        ? Theme.of(context).colorScheme.primary
                                        : null,
                                    fontWeight:
                                        isSelected ? FontWeight.bold : null,
                                  ),
                            ),
                          ),
                          if (isSelected)
                            Icon(
                              Icons.check_circle,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        model.description,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 16),
                      const Divider(),
                      Expanded(
                        child: ListView(
                          children: _getModelFeatures(model.name)
                              .map(
                                (feature) => Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.check,
                                        size: 16,
                                        color:
                                            Theme.of(context).colorScheme.primary,
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          feature,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                      const Divider(),
                      Text(
                        _getModelPrice(model.name),
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
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
      case 'Llama 2':
        return Icons.public;
      default:
        return Icons.smart_toy;
    }
  }

  List<String> _getModelFeatures(String modelName) {
    switch (modelName) {
      case 'GPT-4':
        return [
          'Complex problem solving',
          'Advanced reasoning',
          'Creative tasks',
          'Code generation',
          'Long context window'
        ];
      case 'GPT-3.5':
        return [
          'Quick responses',
          'Cost-effective',
          'General tasks',
          'Good performance'
        ];
      case 'Claude AI':
        return [
          'Long context window',
          'Detailed analysis',
          'Technical writing',
          'Research assistance'
        ];
      case 'Llama 2':
        return [
          'Open source',
          'Local deployment',
          'Privacy focused',
          'Community support'
        ];
      default:
        return ['General AI capabilities'];
    }
  }

  String _getModelPrice(String modelName) {
    switch (modelName) {
      case 'GPT-4':
        return '\$0.03/1K tokens';
      case 'GPT-3.5':
        return '\$0.002/1K tokens';
      case 'Claude AI':
        return '\$0.01/1K tokens';
      case 'Llama 2':
        return 'Free';
      default:
        return 'Contact for pricing';
    }
  }
}