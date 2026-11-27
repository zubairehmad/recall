import 'package:flutter/material.dart';

import '../../../core/widgets/custom_sliver_app_bar.dart';
import '../../../core/widgets/custom_search_bar.dart';
import '../widgets/quick_add_section.dart';
import '../widgets/basic_overview_section.dart';
import '../widgets/recently_added_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const EdgeInsetsGeometry padding = EdgeInsets.symmetric(
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
            title: 'Recall',
            subtitle: 'Your personal knowledge space.',
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: padding,
              child: CustomSearchBar(
                hintText: 'Search your knowledge...',
              ),
            ),
          ),
          SliverPadding(
            padding: padding,
            sliver: QuickAddSection(),
          ),
          SliverPadding(
            padding: padding,
            sliver: BasicOverviewSection(),
          ),
          SliverPadding(
            padding: padding,
            sliver: RecentlyAddedSection(),
          ),
        ],
      ),
    );
  }
}
