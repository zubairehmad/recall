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
  final String onEmpty;

  const DistributionCard({
    super.key,
    required this.sections,
    this.onEmpty = 'No information yet',
  });

  @override
  State<DistributionCard> createState() => _DistributionCardState();
}

class _DistributionCardState extends State<DistributionCard> {
  int? _selectedIdx;
  late int _totalCnt;

  @override
  void initState() {
    super.initState();
    _totalCnt = widget.sections.fold(
      0,
      (s, curr) => s + curr.count,
    );
  }

  @override
  void didUpdateWidget(covariant DistributionCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    _totalCnt = widget.sections.fold(
      0,
      (s, curr) => s + curr.count,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_totalCnt == 0) {
      return Card(
        child: SizedBox(
          height: 220,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.pie_chart_outline,
                  size: 40,
                ),
                const SizedBox(height: 8),
                Text(widget.onEmpty),
              ],
            ),
          ),
        ),
      );
    }

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
                            _selectedIdx != null
                                ? widget.sections[_selectedIdx!].count
                                      .toString()
                                : _totalCnt.toString(),
                            style: TextStyle(
                              fontSize: chartSize * 0.12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            _selectedIdx != null
                                ? widget.sections[_selectedIdx!].label
                                : 'Total',
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
