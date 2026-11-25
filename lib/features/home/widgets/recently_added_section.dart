import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../information/providers/information_provider.dart';
import '../../information/widgets/information_list_item.dart';

class RecentlyAddedSection extends StatelessWidget {
  const RecentlyAddedSection({super.key});

  @override
  Widget build(BuildContext context) {
    final recentlyAdded = context
        .watch<InformationProvider>()
        .recentlyAddedList;

    return SliverMainAxisGroup(
      slivers: [
        SliverToBoxAdapter(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Recently added',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              TextButton.icon(
                onPressed: () {},
                label: const Text('See all'),
                icon: const Icon(Icons.arrow_forward),
                iconAlignment: IconAlignment.end,
              ),
            ],
          ),
        ),
        const SliverToBoxAdapter(
          child: SizedBox(height: 8),
        ),
        SliverList.separated(
          itemBuilder: (_, i) => InformationListItem(
            information: recentlyAdded[i],
          ),
          separatorBuilder: (_, _) => Padding(
            padding: const EdgeInsetsGeometry.symmetric(
              horizontal: 18,
              vertical: 2,
            ),
            child: Divider(
              radius: const BorderRadius.all(Radius.circular(28)),
              color: Theme.of(context).colorScheme.onSurface.withAlpha(100),
            ),
          ),
          itemCount: recentlyAdded.length,
        ),
      ],
    );
  }
}
