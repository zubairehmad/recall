import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class InfoDistributionCard extends StatefulWidget {
  const InfoDistributionCard({super.key});

  @override
  State<InfoDistributionCard> createState() =>
      _InfoDistributionCardState();
}

class _InfoDistributionCardState
    extends State<InfoDistributionCard> {
  final sections = [
    (label: 'Claims', count: 40, color: Colors.blue),
    (label: 'Facts', count: 30, color: Colors.orange),
    (label: 'Tips', count: 20, color: Colors.green),
    (label: 'Notes', count: 10, color: Colors.purple),
  ];

  int? _selectedIdx;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 12),
          Row(
            children: [
              const SizedBox(width: 12),
              Text(
                'Total Info Distribution',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          SizedBox(
            height: 200,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 200,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      PieChart(
                        PieChartData(
                          sections: List.generate(
                            sections.length,
                            (idx) {
                              final item = sections[idx];
                              final isSelected = _selectedIdx == idx;

                              return PieChartSectionData(
                                value: item.count.toDouble(),
                                color: item.color,
                                radius: isSelected ? 30 : 25,
                                showTitle: false,
                              );
                            },
                          ),
                          centerSpaceRadius: 55,
                          sectionsSpace: 3,
                          pieTouchData: PieTouchData(
                            enabled: true,
                            touchCallback: (event, response) {
                              if (event is! FlTapDownEvent ||
                                  response?.touchedSection == null) {
                                return;
                              }

                              final idx =
                                  response!.touchedSection!.touchedSectionIndex;

                              setState(() {
                                _selectedIdx = idx < 0 || idx == _selectedIdx
                                    ? null
                                    : idx;
                              });
                            },
                          ),
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            '100',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Total',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 28),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (int i = 0; i < sections.length; i++) ...[
                      if (i != 0) const SizedBox(height: 2),
                      _LegendItem(
                        label: sections[i].label,
                        color: sections[i].color,
                        count: sections[i].count,
                        selected: _selectedIdx == i,
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  final String label;
  final Color color;
  final int count;
  final bool selected;

  const _LegendItem({
    required this.label,
    required this.color,
    required this.selected,
    this.count = 0,
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
