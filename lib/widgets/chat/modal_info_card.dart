import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:polybot/providers/model_provider.dart';

class ModelInfoCard extends StatelessWidget {
  const ModelInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.model_training,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 12),
                Text(
                  'Select AI Model',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
          Expanded(
            child: Consumer<ModelProvider>(
              builder: (context, modelProvider, child) {
                final models = modelProvider.activeModels;

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: models.length,
                  itemBuilder: (context, index) {
                    final model = models[index];
                    final isSelected =
                        modelProvider.selectedModel?.id == model.id;

                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      color: isSelected
                          ? Theme.of(context)
                              .colorScheme
                              .primaryContainer
                              .withOpacity(0.3)
                          : null,
                      child: ListTile(
                        leading: Icon(
                          _getModelIcon(model.name),
                          color: isSelected
                              ? Theme.of(context).colorScheme.primary
                              : null,
                        ),
                        title: Text(
                          model.name,
                          style: TextStyle(
                            fontWeight: isSelected ? FontWeight.bold : null,
                            color: isSelected
                                ? Theme.of(context).colorScheme.primary
                                : null,
                          ),
                        ),
                        subtitle: Text(model.description),
                        trailing: isSelected
                            ? Icon(
                                Icons.check_circle,
                                color: Theme.of(context).colorScheme.primary,
                              )
                            : null,
                        onTap: () {
                          modelProvider.selectModel(model);
                          Navigator.pop(context);
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
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
      case "Gemini Flash":
        return Icons.emoji_objects;
      default:
        return Icons.smart_toy;
    }
  }
}
