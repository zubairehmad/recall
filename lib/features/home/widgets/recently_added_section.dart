import 'package:flutter/material.dart';

import '../../../core/models/information.dart';
import 'information_list_item.dart';

/// mock data
final _recentlyAddedInfo = [
  Information(
    id: '1',
    title: 'Binary search on answer',
    content: 'You should binary search on answer!',
    type: InformationType.tip,
    createdAt: DateTime.now().subtract(const Duration(hours: 2)),
    updatedAt: DateTime.now().subtract(const Duration(hours: 2)),
  ),
  Information(
    id: '2',
    title: "Newton's third law",
    content: 'Every action has a reaction.',
    type: InformationType.fact,
    status: InformationStatus.verified,
    createdAt: DateTime.now().subtract(const Duration(days: 1)),
    updatedAt: DateTime.now().subtract(const Duration(days: 1)),
  ),
  Information(
    id: '3',
    title: 'Thought about discipline',
    content: 'I should be disciplined!',
    type: InformationType.note,
    createdAt: DateTime.now().subtract(const Duration(days: 2)),
    updatedAt: DateTime.now().subtract(const Duration(days: 2)),
  ),
];

class RecentlyAddedSection extends StatelessWidget {
  const RecentlyAddedSection({super.key});

  @override
  Widget build(BuildContext context) {
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
            information: _recentlyAddedInfo[i],
            onPressed: () {},
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
          itemCount: _recentlyAddedInfo.length,
        ),
      ],
    );
  }
}
