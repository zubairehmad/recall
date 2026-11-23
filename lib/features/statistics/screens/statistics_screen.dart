import 'package:flutter/material.dart';

import '../../../core/widgets/custom_sliver_app_bar.dart';
import '../widgets/info_distribution_card.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const EdgeInsetsGeometry padding = EdgeInsets.symmetric(
      horizontal: 12,
      vertical: 10,
    );

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: SizedBox(height: 12),
          ),
          const CustomSliverAppBar(
            title: 'Simple Statistics',
            subtitle: 'See what you got here',
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 28),
          ),
          const SliverToBoxAdapter(
            child: Padding(
              padding: padding,
              child: InfoDistributionCard(),
            ),
          ),
        ],
      ),
    );
  }
}
