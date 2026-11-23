import 'package:flutter/material.dart';

import 'distribution_card.dart';

class ClaimDistributionCard extends StatelessWidget {
  const ClaimDistributionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
          sections: [
            (label: 'Unreviewed', count: 20, color: Colors.red),
            (label: 'Disputed', count: 3, color: Colors.orange),
            (label: 'Incorrect', count: 5, color: Colors.purple),
            (label: 'Verified', count: 12, color: Colors.green),
          ],
        ),
      ],
    );
  }
}
