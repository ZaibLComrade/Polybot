import 'package:flutter/material.dart';
import 'package:polybot/widgets/common/footer.dart';
import 'package:polybot/widgets/landing/feature_card.dart';
import 'package:polybot/widgets/landing/hero_section.dart';
import 'package:polybot/widgets/landing/testimonial_card.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Polybot'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pushNamed(context, '/pricing'),
            child: const Text('Pricing'),
          ),
          TextButton(
            onPressed: () => Navigator.pushNamed(context, '/login'),
            child: const Text('Login'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const HeroSection(),
            const SizedBox(height: 64),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  Text(
                    'Features',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 32),
                  const Wrap(
                    spacing: 24,
                    runSpacing: 24,
                    children: [
                      FeatureCard(
                        icon: Icons.auto_awesome,
                        title: 'Advanced AI Models',
                        description:
                            'Access to the latest AI models including GPT-4',
                      ),
                      FeatureCard(
                        icon: Icons.security,
                        title: 'Secure Chats',
                        description:
                            'End-to-end encryption for all conversations',
                      ),
                      FeatureCard(
                        icon: Icons.history,
                        title: 'Chat History',
                        description: 'Access your conversation history anytime',
                      ),
                    ],
                  ),
                  const SizedBox(height: 64),
                  Text(
                    'What Our Users Say',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 32),
                  const Wrap(
                    spacing: 24,
                    runSpacing: 24,
                    children: [
                      TestimonialCard(
                        name: 'John Smith',
                        role: 'Software Developer',
                        text:
                            'This AI assistant has significantly improved my productivity.',
                      ),
                      TestimonialCard(
                        name: 'Sarah Johnson',
                        role: 'Content Writer',
                        text: 'The best AI chat application I\'ve ever used.',
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 64),
            const Footer(),
          ],
        ),
      ),
    );
  }
}
