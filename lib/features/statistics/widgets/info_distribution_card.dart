import 'package:flutter/material.dart';

import 'distribution_card.dart';

class InfoDistributionCard extends StatelessWidget {
  const InfoDistributionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Total Info Distribution',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 12),
        DistributionCard(
          sections: [
            (label: 'Claims', count: 52, color: Colors.blue),
            (label: 'Facts', count: 24, color: Colors.orange),
            (label: 'Tips', count: 36, color: Colors.green),
            (label: 'Notes', count: 16, color: Colors.purple),
          ],
        ),
      ],
    );
  }
}
