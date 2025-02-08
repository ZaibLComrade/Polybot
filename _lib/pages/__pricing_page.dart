import 'package:flutter/material.dart';
import '../widgets/common/responsive_builder.dart';

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
            Container(
              padding: const EdgeInsets.all(32.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.secondary,
                  ],
                ),
              ),
              child: Column(
                children: [
                  Text(
                    'Choose Your Plan',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Start with our free plan or upgrade for more features',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: ResponsiveBuilder(
                mobile: _buildPricingCards(context, isMobile: true),
                desktop: _buildPricingCards(context, isMobile: false),
              ),
            ),
            const SizedBox(height: 32),
            _buildComparisonTable(context),
            const SizedBox(height: 48),
            _buildFAQSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildPricingCards(BuildContext context, {required bool isMobile}) {
    final cards = [
      _PricingInfo(
        title: 'Free',
        price: 0,
        period: 'month',
        features: [
          'Basic AI chat',
          '1,000 tokens per day',
          'Standard response time',
          'Basic support',
          'Community access',
        ],
        highlightedFeatures: [],
        isPopular: false,
      ),
      _PricingInfo(
        title: 'Pro',
        price: 9.99,
        period: 'month',
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
      ),
      _PricingInfo(
        title: 'Enterprise',
        price: null,
        period: 'month',
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
        isPopular: false,
      ),
    ];

    if (isMobile) {
      return Column(
        children: cards.map((card) => _buildPriceCard(context, card)).toList(),
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: cards
          .map((card) => Expanded(child: _buildPriceCard(context, card)))
          .toList(),
    );
  }

  Widget _buildPriceCard(BuildContext context, _PricingInfo info) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: Card(
        elevation: info.isPopular ? 8 : 2,
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: info.isPopular
              ? BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primary,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(12),
                )
              : null,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (info.isPopular)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    'Most Popular',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              const SizedBox(height: 16),
              Text(
                info.title,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),
              if (info.price != null)
                RichText(
                  text: TextSpan(
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    children: [
                      TextSpan(text: '\$${info.price}'),
                      TextSpan(
                        text: '/${info.period}',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: Colors.grey[600],
                            ),
                      ),
                    ],
                  ),
                )
              else
                Text(
                  'Custom Pricing',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              const SizedBox(height: 24),
              ...info.features.map((feature) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: info.highlightedFeatures.contains(feature)
                              ? Theme.of(context).colorScheme.primary
                              : Colors.grey,
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            feature,
                            style: TextStyle(
                              fontWeight:
                                  info.highlightedFeatures.contains(feature)
                                      ? FontWeight.bold
                                      : null,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/register'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: info.isPopular
                        ? Theme.of(context).colorScheme.primary
                        : null,
                    foregroundColor: info.isPopular
                        ? Theme.of(context).colorScheme.onPrimary
                        : null,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text(
                    info.price != null ? 'Get Started' : 'Contact Sales',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildComparisonTable(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
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
    );
  }

  DataRow _buildFeatureRow(String feature, String free, String pro, String enterprise) {
    return DataRow(cells: [
      DataCell(Text(feature, style: const TextStyle(fontWeight: FontWeight.bold))),
      DataCell(Text(free)),
      DataCell(Text(pro)),
      DataCell(Text(enterprise)),
    ]);
  }

  Widget _buildFAQSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Frequently Asked Questions',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 24),
          _buildFAQItem(
            context,
            'What happens if I exceed my token limit?',
            'You\'ll be notified when you reach 80% of your limit. Once exceeded, you\'ll need to upgrade or wait for the next day.',
          ),
          _buildFAQItem(
            context,
            'Can I switch plans at any time?',
            'Yes, you can upgrade or downgrade your plan at any time. Changes will be reflected in your next billing cycle.',
          ),
          _buildFAQItem(
            context,
            'Do you offer refunds?',
            'We offer a 30-day money-back guarantee for all paid plans.',
          ),
          _buildFAQItem(
            context,
            'What payment methods do you accept?',
            'We accept all major credit cards, PayPal, and wire transfers for Enterprise plans.',
          ),
        ],
      ),
    );
  }

  Widget _buildFAQItem(BuildContext context, String question, String answer) {
    return ExpansionTile(
      title: Text(
        question,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(answer),
        ),
      ],
    );
  }
}

class _PricingInfo {
  final String title;
  final double? price;
  final String period;
  final List<String> features;
  final List<String> highlightedFeatures;
  final bool isPopular;

  _PricingInfo({
    required this.title,
    required this.price,
    required this.period,
    required this.features,
    required this.highlightedFeatures,
    required this.isPopular,
  });
}