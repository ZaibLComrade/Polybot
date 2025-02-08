import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:polybot/providers/chat_provider.dart';
import 'package:polybot/providers/auth_provider.dart';
import 'package:polybot/providers/model_provider.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isSmallScreen = MediaQuery.of(context).size.width < 600;
    final chatProvider = Provider.of<ChatProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);
    final modelProvider = Provider.of<ModelProvider>(context);

    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 32,
                  backgroundColor: theme.colorScheme.surface,
                  child: Text(
                    authProvider.currentUser?.username.substring(0, 1).toUpperCase() ?? 'G',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  authProvider.currentUser?.username ?? 'Guest',
                  style: theme.textTheme.titleLarge,
                ),
                Text(
                  authProvider.currentUser?.email ?? '',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.textTheme.bodyMedium?.color?.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ),
          if (authProvider.currentUser != null) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ElevatedButton.icon(
                onPressed: () async {
                  if (modelProvider.selectedModel == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please select an AI model first'),
                      ),
                    );
                    return;
                  }

                  try {
                    await chatProvider.createNewSession(
                      authProvider.currentUser!.id,
                      modelProvider.selectedModel!.id,
                      'New Chat',
                    );

                    if (isSmallScreen) {
                      Navigator.pop(context);
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error creating chat: ${e.toString()}')),
                    );
                  }
                },
                icon: const Icon(Icons.add),
                label: const Text('New Chat'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 48),
                ),
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 8),
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      'Recent Chats',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  ...chatProvider.sessions.map((session) => ListTile(
                        leading: CircleAvatar(
                          backgroundColor:
                              Theme.of(context).colorScheme.primaryContainer,
                          child: Icon(
                            _getModelIcon(session.modelName),
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        title: Text(session.title),
                        subtitle: Text(
                          session.lastMessage ?? 'No messages yet',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        selected: chatProvider.currentSession?.id == session.id,
                        onTap: () {
                          chatProvider.setCurrentSession(session.id);
                          if (isSmallScreen) {
                            Navigator.pop(context);
                          }
                        },
                      )),
                  if (!isSmallScreen) ...[
                    const Divider(height: 32),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Text(
                        'AI Models',
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
                        selected: modelProvider.selectedModel?.id == model.id,
                        onTap: () {
                          modelProvider.selectModel(model);
                        },
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
          const Divider(height: 1),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),
        ],
      ),
    );
  }

  IconData _getModelIcon(String modelName) {
    switch (modelName.toLowerCase()) {
      case 'gpt-4':
        return Icons.auto_awesome;
      case 'gpt-3.5':
        return Icons.bolt;
      case 'claude ai':
        return Icons.psychology;
      case 'llama 2':
        return Icons.public;
      default:
        return Icons.smart_toy;
    }
  }
}