import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import 'legend_item.dart';

class DistributionCard extends StatefulWidget {
  final List<
    ({
      MaterialColor color,
      int count,
      String label,
    })
  >
  sections;

  const DistributionCard({
    super.key,
    required this.sections,
  });

  @override
  State<DistributionCard> createState() => _DistributionCardState();
}

class _DistributionCardState extends State<DistributionCard> {
  int? _selectedIdx;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final chartSize = (constraints.maxWidth * 0.48).clamp(
            130.0,
            220.0,
          );

          final centerRadius = chartSize * 0.275;
          final sectionRadius = chartSize * 0.125;

          return SizedBox(
            height: chartSize,
            child: Row(
              children: [
                SizedBox(
                  width: chartSize,
                  height: chartSize,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      PieChart(
                        PieChartData(
                          sections: List.generate(
                            widget.sections.length,
                            (idx) {
                              final item = widget.sections[idx];
                              final isSelected = _selectedIdx == idx;

                              return PieChartSectionData(
                                value: item.count.toDouble(),
                                color: item.color,
                                radius: isSelected
                                    ? sectionRadius * 1.15
                                    : sectionRadius,
                                showTitle: false,
                              );
                            },
                          ),
                          centerSpaceRadius: centerRadius,
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
                          Text(
                            widget.sections
                                .fold<int>(
                                  0,
                                  (prev, curr) => prev + curr.count,
                                )
                                .toString(),
                            style: TextStyle(
                              fontSize: chartSize * 0.12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Total',
                            style: Theme.of(
                              context,
                            ).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (int i = 0; i < widget.sections.length; i++) ...[
                        if (i != 0) const SizedBox(height: 6),
                        LegendItem(
                          label: widget.sections[i].label,
                          color: widget.sections[i].color,
                          count: widget.sections[i].count,
                          selected: _selectedIdx == i,
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
