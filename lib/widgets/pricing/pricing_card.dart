import 'package:flutter/material.dart';

class PricingCard extends StatelessWidget {
  final String title;
  final double? price;
  final String period;
  final List<String> features;
  final List<String> highlightedFeatures;
  final bool isPopular;
  final VoidCallback onSelect;
  final String buttonText;

  const PricingCard({
    super.key,
    required this.title,
    required this.price,
    this.period = 'month',
    required this.features,
    this.highlightedFeatures = const [],
    this.isPopular = false,
    required this.onSelect,
    this.buttonText = 'Get Started',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: Card(
        elevation: isPopular ? 8 : 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: isPopular
              ? BorderSide(
                  color: Theme.of(context).colorScheme.primary, width: 2)
              : BorderSide.none,
        ),
        child: Container(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment
                  .spaceBetween, // Distributes space between children
              children: [
                // Group top widgets together
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (isPopular) _buildPopularBadge(context),
                    _buildHeader(context),
                    const SizedBox(height: 24),
                    _buildFeaturesList(context),
                  ],
                ),
                // Action button is placed at the bottom
                _buildActionButton(context),
              ],
            )),
      ),
    );
  }

  Widget _buildPopularBadge(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.star,
            size: 16,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          const SizedBox(width: 4),
          Text(
            'Most Popular',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        if (price != null)
          RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
              children: [
                TextSpan(text: '\$${price!.toStringAsFixed(2)}'),
                TextSpan(
                  text: '/$period',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
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
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
      ],
    );
  }

  Widget _buildFeaturesList(BuildContext context) {
    return Column(
      children: features.map((feature) {
        final isHighlighted = highlightedFeatures.contains(feature);
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: isHighlighted
                      ? Theme.of(context).colorScheme.primaryContainer
                      : Theme.of(context).colorScheme.surfaceContainerHighest,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check,
                  size: 16,
                  color: isHighlighted
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  feature,
                  style: TextStyle(
                    fontWeight: isHighlighted ? FontWeight.bold : null,
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildActionButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onSelect,
        style: ElevatedButton.styleFrom(
          backgroundColor:
              isPopular ? Theme.of(context).colorScheme.primary : null,
          foregroundColor:
              isPopular ? Theme.of(context).colorScheme.onPrimary : null,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(buttonText),
      ),
    );
  }
}
