import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/information_stats_provider.dart';

class ReviewProgressIndicator extends StatelessWidget {
  const ReviewProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.brightnessOf(context) == Brightness.dark;
    final cnts = context.select<InformationStatsProvider, (int, int)>(
      (p) => (p.reviewedClaimsCnt, p.claimsCnt),
    );

    final reviewed = cnts.$1;
    final total = cnts.$2;

    if (total == 0) {
      return const SizedBox.shrink();
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Claim Review Progress',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text('$reviewed/$total'),
              ],
            ),
            const SizedBox(height: 12),
            LinearProgressIndicator(
              value: reviewed / total,
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
