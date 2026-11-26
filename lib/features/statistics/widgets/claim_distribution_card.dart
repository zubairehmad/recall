import 'package:flutter/material.dart';

import 'distribution_card.dart';

class ClaimDistributionCard extends StatelessWidget {
  const ClaimDistributionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Claims Distribution',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 12),
        DistributionCard(
          onEmpty: 'No claims yet',
          sections: [
            (label: 'Unreviewed', count: 10, color: Colors.red),
            (label: 'Disputed', count: 14, color: Colors.orange),
            (label: 'Incorrect', count: 8, color: Colors.purple),
            (label: 'Verified', count: 20, color: Colors.green),
          ],
        ),
      ],
    );
  }
}
