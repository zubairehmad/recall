import 'package:flutter/material.dart';

class ReviewProgressIndicator extends StatelessWidget {
  const ReviewProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.brightnessOf(context) == Brightness.dark;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Claim Review Progress',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text('42/52'),
              ],
            ),
            SizedBox(height: 12),
            LinearProgressIndicator(
              value: 0.8,
              minHeight: 6,
              color: Colors.green.shade700,
              backgroundColor: isDarkMode
                  ? Colors.grey.shade700
                  : Colors.grey.shade400,
              borderRadius: const BorderRadius.all(Radius.circular(28)),
            ),
          ],
        ),
      ),
    );
  }
}
