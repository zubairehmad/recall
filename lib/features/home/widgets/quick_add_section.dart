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
            _GridElement(
              title: 'Claim',
              onPressed: () {},
            ),
            _GridElement(
              title: 'Fact',
              onPressed: () {},
            ),
            _GridElement(
              title: 'Tip',
              onPressed: () {},
            ),
            _GridElement(
              title: 'Note',
              onPressed: () {},
            ),
          ]),
        ),
      ],
    );
  }
}

class _GridElement extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const _GridElement({
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
