import 'package:flutter/material.dart';
import 'package:polybot/widgets/common/responsive_builder.dart';
import 'package:polybot/widgets/pricing/pricing_card.dart';

class PricingPage extends StatelessWidget {
  const PricingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pricing Plans'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(context),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: ResponsiveBuilder(
                mobile: _buildPricingCards(context, isMobile: true),
                desktop: _buildPricingCards(context, isMobile: false),
              ),
            ),
            const SizedBox(height: 32),
            _buildComparisonTable(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.secondary,
          ],
        ),
      ),
      child: Column(
        children: [
          Text(
            'Choose Your Perfect Plan',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16),
          Text(
            'Start with our free plan or upgrade for advanced features',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color:
                      Theme.of(context).colorScheme.onPrimary.withOpacity(0.9),
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildPricingCards(BuildContext context, {required bool isMobile}) {
    final cards = [
      PricingCard(
        title: 'Free',
        price: 0,
        features: [
          'Basic AI chat',
          '1,000 tokens per day',
          'Standard response time',
          'Basic support',
          'Community access',
        ],
        onSelect: () => Navigator.pushNamed(context, '/register'),
      ),
      PricingCard(
        title: 'Pro',
        price: 9.99,
        features: [
          'Advanced AI models',
          '50,000 tokens per day',
          'Priority response time',
          'Priority support',
          'Custom AI training',
          'API access',
          'Team collaboration',
        ],
        highlightedFeatures: [
          'Advanced AI models',
          'Priority support',
          'API access',
        ],
        isPopular: true,
        onSelect: () => Navigator.pushNamed(context, '/register'),
      ),
      PricingCard(
        title: 'Enterprise',
        price: null,
        features: [
          'Custom AI solutions',
          'Unlimited tokens',
          'Dedicated support',
          'SLA guarantee',
          'Custom integrations',
          'Team management',
          'Advanced analytics',
          'Custom training',
        ],
        highlightedFeatures: [
          'Custom AI solutions',
          'Dedicated support',
          'Custom integrations',
        ],
        buttonText: 'Contact Sales',
        onSelect: () => Navigator.pushNamed(context, '/contact'),
      ),
    ];

    if (isMobile) {
      return Column(
        children: cards,
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: cards.map((card) => Expanded(child: card)).toList(),
    );
  }

  Widget _buildComparisonTable(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: ConstrainedBox(
        constraints: BoxConstraints(minWidth: screenWidth),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: DataTable(
            columns: const [
              DataColumn(label: Text('Feature')),
              DataColumn(label: Text('Free')),
              DataColumn(label: Text('Pro')),
              DataColumn(label: Text('Enterprise')),
            ],
            rows: [
              _buildFeatureRow('Daily Tokens', '1,000', '50,000', 'Unlimited'),
              _buildFeatureRow('AI Models', 'Basic', 'Advanced', 'Custom'),
              _buildFeatureRow('Response Time', 'Standard', 'Priority', 'SLA'),
              _buildFeatureRow('Support', 'Basic', 'Priority', 'Dedicated'),
              _buildFeatureRow('Team Members', '1', 'Up to 10', 'Unlimited'),
              _buildFeatureRow('API Access', '❌', '✓', '✓'),
              _buildFeatureRow('Custom Training', '❌', '✓', '✓'),
              _buildFeatureRow('Analytics', 'Basic', 'Advanced', 'Custom'),
            ],
          ),
        ),
      ),
    );
  }

  DataRow _buildFeatureRow(
      String feature, String free, String pro, String enterprise) {
    return DataRow(cells: [
      DataCell(
          Text(feature, style: const TextStyle(fontWeight: FontWeight.bold))),
      DataCell(Text(free)),
      DataCell(Text(pro)),
      DataCell(Text(enterprise)),
    ]);
  }
}
