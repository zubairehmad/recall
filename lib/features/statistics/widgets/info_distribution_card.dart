import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/information_stats_provider.dart';
import 'distribution_card.dart';

class InfoDistributionCard extends StatelessWidget {
  const InfoDistributionCard({super.key});

  @override
  Widget build(BuildContext context) {
    final cnts = context.select<InformationStatsProvider, (int, int, int, int)>(
      (p) => (
        p.claimsCnt,
        p.factsCnt,
        p.tipsCnt,
        p.notesCnt,
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Total Info Distribution',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        DistributionCard(
          sections: [
            if (cnts.$1 > 0)
              (label: 'Claims', count: cnts.$1, color: Colors.blue),
            if (cnts.$2 > 0)
              (label: 'Facts', count: cnts.$2, color: Colors.orange),
            if (cnts.$3 > 0)
              (label: 'Tips', count: cnts.$3, color: Colors.green),
            if (cnts.$4 > 0)
              (label: 'Notes', count: cnts.$4, color: Colors.purple),
          ],
        ),
      ],
    );
  }
}
