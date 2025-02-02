import 'package:flutter/material.dart';
import 'package:polybot/widgets/common/responsive_builder.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help Center'),
      ),
      body: ResponsiveBuilder(
        mobile: _buildMobileLayout(context),
        desktop: _buildDesktopLayout(context),
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchBar(context),
            const SizedBox(height: 24),
            _buildFAQSection(context),
            const SizedBox(height: 24),
            _buildContactSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 300,
          child: _buildSidebar(context),
        ),
        const VerticalDivider(width: 1),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSearchBar(context),
                const SizedBox(height: 32),
                _buildFAQSection(context),
                const SizedBox(height: 32),
                _buildContactSection(context),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSidebar(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: const Icon(Icons.question_answer),
          title: const Text('FAQs'),
          selected: true,
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.book),
          title: const Text('Documentation'),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.video_library),
          title: const Text('Tutorials'),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.support_agent),
          title: const Text('Contact Support'),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.forum),
          title: const Text('Community'),
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search for help...',
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Widget _buildFAQSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Frequently Asked Questions',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 16),
        _buildFAQItem(
          context,
          'How do I get started?',
          'Create an account and start chatting with our AI assistant right away.',
        ),
        _buildFAQItem(
          context,
          'What AI models are available?',
          'We offer various models including GPT-4, GPT-3.5, Claude, and more.',
        ),
        _buildFAQItem(
          context,
          'How does billing work?',
          'We offer pay-as-you-go and subscription plans. Check our pricing page for details.',
        ),
        _buildFAQItem(
          context,
          'Is my data secure?',
          'Yes, we use end-to-end encryption and follow strict security protocols.',
        ),
      ],
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

  Widget _buildContactSection(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Still need help?',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            const Text(
              'Our support team is available 24/7 to assist you with any questions or concerns.',
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.email),
                  label: const Text('Email Support'),
                  onPressed: () {},
                ),
                const SizedBox(width: 16),
                ElevatedButton.icon(
                  icon: const Icon(Icons.chat),
                  label: const Text('Live Chat'),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
