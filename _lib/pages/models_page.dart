import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/chat_provider.dart';
import '../widgets/common/responsive_builder.dart';

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
    final models = [
      _ModelInfo(
        name: 'GPT-4',
        description: 'Most advanced model with superior reasoning capabilities',
        icon: Icons.auto_awesome,
        features: [
          'Complex problem solving',
          'Advanced reasoning',
          'Creative tasks'
        ],
        price: '\$0.03/1K tokens',
      ),
      _ModelInfo(
        name: 'GPT-3.5 Turbo',
        description: 'Fast and efficient for most everyday tasks',
        icon: Icons.bolt,
        features: ['Quick responses', 'Cost-effective', 'General tasks'],
        price: '\$0.002/1K tokens',
      ),
      _ModelInfo(
        name: 'Claude 2',
        description: 'Specialized in analysis and writing',
        icon: Icons.psychology,
        features: [
          'Long context window',
          'Detailed analysis',
          'Technical writing'
        ],
        price: '\$0.01/1K tokens',
      ),
      _ModelInfo(
        name: 'Llama 2',
        description: 'Open-source model with good performance',
        icon: Icons.public,
        features: ['Open source', 'Local deployment', 'Privacy focused'],
        price: 'Free',
      ),
    ];

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
        return _buildModelCard(context, model);
      },
    );
  }

  Widget _buildModelCard(BuildContext context, _ModelInfo model) {
    final chatProvider = Provider.of<ChatProvider>(context);
    final isSelected = chatProvider.selectedModel == model.name;

    return Card(
      elevation: isSelected ? 4 : 1,
      child: InkWell(
        onTap: () {
          chatProvider.setModel(model.name);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Switched to ${model.name}')),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(model.icon,
                      size: 32, color: Theme.of(context).colorScheme.primary),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      model.name,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  if (isSelected)
                    Icon(Icons.check_circle,
                        color: Theme.of(context).colorScheme.primary),
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
                child: ListView.builder(
                  itemCount: model.features.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        children: [
                          Icon(Icons.check,
                              size: 16,
                              color: Theme.of(context).colorScheme.primary),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              model.features[index],
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const Divider(),
              Text(
                model.price,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ModelInfo {
  final String name;
  final String description;
  final IconData icon;
  final List<String> features;
  final String price;

  _ModelInfo({
    required this.name,
    required this.description,
    required this.icon,
    required this.features,
    required this.price,
  });
}
