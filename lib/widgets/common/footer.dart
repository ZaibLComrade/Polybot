import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      color: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildColumn(context, 'Company', [
                'About',
                'Careers',
                'Blog',
                'Press',
              ]),
              _buildColumn(context, 'Product', [
                'Features',
                'Pricing',
                'Security',
                'Enterprise',
              ]),
              _buildColumn(context, 'Resources', [
                'Documentation',
                'Tutorials',
                'API Reference',
                'Community',
              ]),
              _buildColumn(context, 'Legal', [
                'Privacy',
                'Terms',
                'Cookie Policy',
                'License',
              ]),
            ],
          ),
          const SizedBox(height: 32),
          const Divider(),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '© ${DateTime.now().year} Polybot. All rights reserved.',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.facebook),
                    onPressed: () {},
                  ),
                  // IconButton(
                  //   icon: const Icon(Icons.twitter),
                  //   onPressed: () {},
                  // ),
                  // IconButton(
                  //   icon: const Icon(Icons.linkedin),
                  //   onPressed: () {},
                  // ),
                  // IconButton(
                  //   icon: const Icon(Icons.github),
                  //   onPressed: () {},
                  // ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildColumn(BuildContext context, String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 16),
        ...items.map(
          (item) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: TextButton(
              onPressed: () {},
              child: Text(item),
            ),
          ),
        ),
      ],
    );
  }
}