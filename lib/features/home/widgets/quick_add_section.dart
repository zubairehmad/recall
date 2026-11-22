import 'package:flutter/material.dart';

class QuickAddSection extends StatelessWidget {
  const QuickAddSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverMainAxisGroup(
      slivers: [
        const SliverToBoxAdapter(
          child: Text(
            'Quick add',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        const SliverToBoxAdapter(
          child: SizedBox(height: 8),
        ),
        SliverGrid(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 6,
            mainAxisSpacing: 8,
            childAspectRatio: 3,
          ),
          delegate: SliverChildListDelegate([
            _GridItem(
              title: 'Claim',
              onPressed: () {},
            ),
            _GridItem(
              title: 'Fact',
              onPressed: () {},
            ),
            _GridItem(
              title: 'Tip',
              onPressed: () {},
            ),
            _GridItem(
              title: 'Note',
              onPressed: () {},
            ),
          ]),
        ),
      ],
    );
  }
}

class _GridItem extends StatelessWidget {
  final String title;

  final VoidCallback onPressed;

  const _GridItem({
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            children: [
              const Icon(Icons.add),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
