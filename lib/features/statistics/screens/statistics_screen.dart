import 'package:flutter/material.dart';

import '../../../core/widgets/custom_sliver_app_bar.dart';
import '../widgets/info_distribution_card.dart';
import '../widgets/claim_distribution_card.dart';
import '../widgets/review_progress_indicator.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const padding = EdgeInsets.symmetric(
      horizontal: 12,
      vertical: 10,
    );

    return const Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(height: 12),
          ),
          CustomSliverAppBar(
            title: 'Simple Statistics',
            subtitle: 'See what you got here.',
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: 12),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: padding,
              child: InfoDistributionCard(),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: padding,
              child: ClaimDistributionCard(),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: padding,
              child: ReviewProgressIndicator(),
            ),
          ),
        ],
      ),
    );
  }
}
