import 'package:flutter/material.dart';

class BasicOverviewSection extends StatelessWidget {
  const BasicOverviewSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverMainAxisGroup(
      slivers: [
        SliverToBoxAdapter(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Your collection',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              TextButton.icon(
                onPressed: () {},
                label: const Text('See more'),
                icon: const Icon(Icons.arrow_forward),
                iconAlignment: IconAlignment.end,
              ),
            ],
          ),
        ),
        const SliverToBoxAdapter(
          child: SizedBox(height: 8),
        ),
        SliverToBoxAdapter(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final width = (constraints.maxWidth - 6) / 2;

              return Wrap(
                spacing: 6,
                runSpacing: 8,
                children: [
                  SizedBox(
                    width: width,
                    child: _CustomGridItem(
                      icon: const Icon(Icons.library_books),
                      number: 128,
                      text: 'Total saved',
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(
                    width: width,
                    child: _CustomGridItem(
                      icon: const Icon(Icons.verified_outlined),
                      number: 42,
                      text: 'Reviewed claims',
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(
                    width: width,
                    child: _CustomGridItem(
                      icon: const Icon(Icons.lightbulb_outline),
                      number: 36,
                      text: 'Tips',
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(
                    width: width,
                    child: _CustomGridItem(
                      icon: const Icon(Icons.bookmark_outline),
                      number: 16,
                      text: 'Notes',
                      onPressed: () {},
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

class _CustomGridItem extends StatelessWidget {
  final int number;
  final String text;
  final Icon icon;
  final VoidCallback onPressed;

  const _CustomGridItem({
    required this.icon,
    required this.text,
    required this.number,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              icon,
              const SizedBox(height: 4),
              Text(
                number.toString(),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                text,
                style: TextStyle(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withAlpha(178),
                ),
                softWrap: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
