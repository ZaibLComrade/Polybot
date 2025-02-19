import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:polybot/providers/chat_provider.dart';
import 'package:polybot/providers/model_provider.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isSmallScreen = MediaQuery.of(context).size.width < 600;
    final modelProvider = Provider.of<ModelProvider>(context);
    final chatProvider = Provider.of<ChatProvider>(context);

    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.chat_bubble_outline,
                  size: 48,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(height: 16),
                Text(
                  'Polybot Chat',
                  style: theme.textTheme.headlineSmall,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ElevatedButton.icon(
              onPressed: () {
                chatProvider.clearChat();
                if (isSmallScreen) {
                  Navigator.pop(context);
                }
              },
              icon: const Icon(Icons.add),
              label: const Text('New Chat'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
              ),
            ),
          ),
          const Divider(),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 8),
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text(
                    'Available Models',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                ...modelProvider.activeModels.map(
                  (model) => ListTile(
                    leading: Icon(
                      _getModelIcon(model.name),
                      color: modelProvider.selectedModel?.id == model.id
                          ? theme.colorScheme.primary
                          : null,
                    ),
                    title: Text(
                      model.name,
                      style: TextStyle(
                        color: modelProvider.selectedModel?.id == model.id
                            ? theme.colorScheme.primary
                            : null,
                        fontWeight: modelProvider.selectedModel?.id == model.id
                            ? FontWeight.bold
                            : null,
                      ),
                    ),
                    subtitle: Text(model.description),
                    selected: modelProvider.selectedModel?.id == model.id,
                    onTap: () {
                      modelProvider.selectModel(model);
                      if (isSmallScreen) {
                        Navigator.pop(context);
                      }
                    },
                  ),
                ),
              ],
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