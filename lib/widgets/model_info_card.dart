import 'package:flutter/material.dart';

class ModelInfoCard extends StatelessWidget {
  const ModelInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Current Model', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('OpenAI ChatGPT-4'),
              ],
            ),
            Switch(value: true, onChanged: (bool value) {}),
          ],
        ),
      ),
    );
  }
}