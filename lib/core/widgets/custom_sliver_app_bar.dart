import 'package:flutter/material.dart';

class CustomSliverAppBar extends StatelessWidget {
  final String title;
  final String? subtitle;

  final List<Widget>? actions;

  const CustomSliverAppBar({
    super.key,
    required this.title,
    this.subtitle,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      actions: actions,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 4),
            Text(
              subtitle!,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withAlpha(178),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
