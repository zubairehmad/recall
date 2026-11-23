import 'package:flutter/material.dart';

import '../../../core/models/information.dart';
import '../../../core/widgets/custom_sliver_app_bar.dart';
import '../widgets/search_and_section.dart';
import '../widgets/information_list_item.dart';

/// mock data
final _infoList = [
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
  Information(
    id: '4',
    title: "Pakistan's independence date",
    content: '14th August, 1947',
    type: InformationType.fact,
    createdAt: DateTime.now().subtract(const Duration(days: 7)),
    updatedAt: DateTime.now().subtract(const Duration(days: 7)),
  ),
  Information(
    id: '5',
    title: "World War 2 was consipiracy!",
    content: 'I dont know!!',
    type: InformationType.claim,
    claimStatus: ClaimStatus.unreviewed,
    createdAt: DateTime.now().subtract(const Duration(days: 23)),
    updatedAt: DateTime.now().subtract(const Duration(days: 23)),
  ),
];

class InformationListScreen extends StatelessWidget {
  const InformationListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const EdgeInsetsGeometry padding = EdgeInsets.symmetric(
      horizontal: 12,
      vertical: 10,
    );

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CustomSliverAppBar(
            title: 'Library',
            actions: [
              Padding(
                padding: const EdgeInsetsGeometry.only(right: 8),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.add),
                ),
              ),
            ],
          ),
          const SliverPadding(
            padding: padding,
            sliver: SearchAndFilterSection(),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 8),
          ),
          SliverPadding(
            padding: padding,
            sliver: SliverList.separated(
              itemBuilder: (_, i) => InformationListItem(
                information: _infoList[i],
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
              itemCount: _infoList.length,
            ),
          ),
        ],
      ),
    );
  }
}
