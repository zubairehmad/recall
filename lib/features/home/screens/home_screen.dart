import 'package:flutter/material.dart';

import '../widgets/custom_search_bar.dart';
import '../widgets/quick_add_section.dart';
import '../widgets/basic_overview_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
          SliverAppBar(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Recall',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  'Your personal knowledge space.',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withAlpha(178),
                  ),
                ),
              ],
            ),
          ),
          const SliverToBoxAdapter(
            child: Padding(
              padding: padding,
              child: CustomSearchBar(),
            ),
          ),
          const SliverPadding(
            padding: padding,
            sliver: QuickAddSection(),
          ),
          const SliverPadding(
            padding: padding,
            sliver: BasicOverviewSection(),
          ),
        ],
      ),
    );
  }
}
