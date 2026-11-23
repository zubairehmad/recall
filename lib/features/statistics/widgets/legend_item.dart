import 'package:flutter/material.dart';

class LegendItem extends StatelessWidget {
  final String label;
  final Color color;
  final int count;
  final bool selected;

  const LegendItem({
    super.key,
    required this.label,
    required this.color,
    required this.selected,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadiusGeometry.all(
            Radius.circular(selected ? 12 : 10),
          ),
          child: SizedBox.square(
            dimension: selected ? 12 : 10,
            child: ColoredBox(color: color),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          "$label - $count",
          style: selected ? const TextStyle(fontWeight: FontWeight.bold) : null,
        ),
      ],
    );
  }
}
