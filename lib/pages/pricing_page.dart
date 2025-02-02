import 'package:flutter/material.dart';
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
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Text(
                'Choose Your Plan',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 16),
              Text(
                'Start with our free plan or upgrade for more features',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.grey[600],
                    ),
              ),
              const SizedBox(height: 48),
              const Row(
                children: [
                  PriceCard(
                    title: 'Free',
                    price: '\$0',
                    features: [
                      'Basic AI chat',
                      'Limited messages per day',
                      'Standard response time',
                      'Basic support',
                    ],
                    isPro: false,
                  ),
                  PriceCard(
                    title: 'Pro',
                    price: '\$9.99',
                    features: [
                      'Advanced AI models',
                      'Unlimited messages',
                      'Priority response time',
                      'Priority support',
                      'Custom AI training',
                    ],
                    isPro: true,
                  ),
                  PriceCard(
                    title: 'Enterprise',
                    price: 'Custom',
                    features: [
                      'Custom AI solutions',
                      'Dedicated support',
                      'SLA guarantee',
                      'Custom integrations',
                      'Team management',
                    ],
                    isPro: false,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
