import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:polybot/providers/chat_provider.dart';
import 'package:polybot/widgets/common/skeleton_loader.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final _searchController = TextEditingController();
  String _filter = 'all';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat History'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _showFilterDialog,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search conversations...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                  },
                ),
              ),
              onChanged: (value) {
                // Implement search
                setState(() {});
              },
            ),
          ),
          Expanded(
            child: _buildHistoryList(),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryList() {
    // Simulated history data
    final history = List.generate(
      20,
      (index) => _ChatHistory(
        id: 'chat_$index',
        title: 'Conversation ${index + 1}',
        lastMessage: 'Last message from conversation ${index + 1}',
        timestamp: DateTime.now().subtract(Duration(days: index)),
        model: index % 2 == 0 ? 'GPT-4' : 'GPT-3.5',
      ),
    );

    return ListView.builder(
      itemCount: history.length,
      itemBuilder: (context, index) {
        final chat = history[index];
        return _buildHistoryItem(chat);
      },
    );
  }

  Widget _buildHistoryItem(_ChatHistory chat) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          child: Text(
            chat.title[0],
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          ),
        ),
        title: Text(chat.title),
        subtitle: Text(chat.lastMessage),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              _formatDate(chat.timestamp),
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Text(
              chat.model,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
          ],
        ),
        onTap: () {
          // Navigate to chat detail
          Navigator.pushNamed(context, '/chat');
        },
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'Today';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return '${date.month}/${date.day}/${date.year}';
    }
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Filter Conversations'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile(
                title: const Text('All'),
                value: 'all',
                groupValue: _filter,
                onChanged: (value) {
                  setState(() {
                    _filter = value.toString();
                  });
                  Navigator.pop(context);
                },
              ),
              RadioListTile(
                title: const Text('GPT-4'),
                value: 'gpt4',
                groupValue: _filter,
                onChanged: (value) {
                  setState(() {
                    _filter = value.toString();
                  });
                  Navigator.pop(context);
                },
              ),
              RadioListTile(
                title: const Text('GPT-3.5'),
                value: 'gpt3',
                groupValue: _filter,
                onChanged: (value) {
                  setState(() {
                    _filter = value.toString();
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ChatHistory {
  final String id;
  final String title;
  final String lastMessage;
  final DateTime timestamp;
  final String model;

  _ChatHistory({
    required this.id,
    required this.title,
    required this.lastMessage,
    required this.timestamp,
    required this.model,
  });
}
