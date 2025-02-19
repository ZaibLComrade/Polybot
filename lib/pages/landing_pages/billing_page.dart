import 'package:flutter/material.dart';
import 'package:polybot/widgets/common/responsive_builder.dart';

class BillingPage extends StatelessWidget {
  const BillingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Billing'),
      ),
      body: ResponsiveBuilder(
        mobile: _buildMobileLayout(context),
        desktop: _buildDesktopLayout(context),
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSubscriptionCard(context),
          const SizedBox(height: 24),
          _buildUsageStats(context),
          const SizedBox(height: 24),
          _buildBillingHistory(context),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSubscriptionCard(context),
                const SizedBox(height: 24),
                _buildUsageStats(context),
              ],
            ),
          ),
        ),
        const VerticalDivider(width: 1),
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: _buildBillingHistory(context),
          ),
        ),
      ],
    );
  }

  Widget _buildSubscriptionCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pro Plan',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    Text(
                      '\$9.99/month',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Upgrade'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const LinearProgressIndicator(value: 0.7),
            const SizedBox(height: 8),
            Text(
              '7,000 / 10,000 tokens used this month',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUsageStats(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Usage Statistics',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        GridView.count(
          crossAxisCount: ResponsiveBuilder.isMobile(context) ? 2 : 3,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          children: [
            _buildStatCard(
              context,
              'Total Chats',
              '156',
              Icons.chat_bubble,
            ),
            _buildStatCard(
              context,
              'Messages',
              '1,234',
              Icons.message,
            ),
            _buildStatCard(
              context,
              'Tokens Used',
              '7,000',
              Icons.token,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard(
    BuildContext context,
    String title,
    String value,
    IconData icon,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 32,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBillingHistory(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Billing History',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        Card(
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 5,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              return ListTile(
                leading: const Icon(Icons.receipt),
                title: Text('Invoice #${1001 + index}'),
                subtitle: Text(
                  'Pro Plan - ${DateTime.now().subtract(Duration(days: index * 30)).month}/'
                  '${DateTime.now().subtract(Duration(days: index * 30)).day}/'
                  '${DateTime.now().subtract(Duration(days: index * 30)).year}',
                ),
                trailing: Text(
                  '\$9.99',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  // Download invoice
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
