import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/information_stats_provider.dart';
import 'distribution_card.dart';

class ClaimDistributionCard extends StatelessWidget {
  const ClaimDistributionCard({super.key});

  @override
  Widget build(BuildContext context) {
    final cnts = context.select<InformationStatsProvider, (int, int, int, int)>(
      (p) => (
        p.unreviewedClaimsCnt,
        p.disputedClaimsCnt,
        p.incorrectClaimsCnt,
        p.verifiedClaimsCnt,
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Claims Distribution',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        DistributionCard(
          onEmpty: 'No claims yet',
          sections: [
            if (cnts.$1 > 0)
              (label: 'Unreviewed', count: cnts.$1, color: Colors.red),
            if (cnts.$2 > 0)
              (label: 'Disputed', count: cnts.$2, color: Colors.orange),
            if (cnts.$3 > 0)
              (label: 'Incorrect', count: cnts.$3, color: Colors.purple),
            if (cnts.$4 > 0)
              (label: 'Verified', count: cnts.$4, color: Colors.green),
          ],
        ),
      ],
    );
  }
}
