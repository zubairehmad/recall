import 'package:flutter/material.dart';

import '../../../core/widgets/custom_search_bar.dart';
import '../models/information.dart';

class SearchAndFilterSection extends StatefulWidget {
  final bool disable;

  const SearchAndFilterSection({
    super.key,
    this.disable = false,
  });

  @override
  State<SearchAndFilterSection> createState() => _SearchAndFilterSectionState();
}

class _SearchAndFilterSectionState extends State<SearchAndFilterSection> {
  InformationType? _selectedType;

  void _setSelectedType(InformationType? type) {
    if (_selectedType != type) {
      setState(() => _selectedType = type);
    }
  }

  Future<void> _handleFilterOptions() async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      constraints: const BoxConstraints(maxWidth: 600),
      builder: (ctx) {
        return Padding(
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
            bottom: 24,
          ),
          child: FilterOptionSheetWidget(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SliverMainAxisGroup(
      slivers: [
        SliverToBoxAdapter(
          child: CustomSearchBar(
            hintText: 'Search your collection...',
            disable: widget.disable,
            trailing: [
              IconButton(
                onPressed: widget.disable ? null : _handleFilterOptions,
                icon: const Icon(Icons.tune),
              ),
            ],
          ),
        ),
        const SliverToBoxAdapter(
          child: SizedBox(height: 8),
        ),
        SliverToBoxAdapter(
          child: Wrap(
            spacing: 2,
            children: [
              _TypeFilterChip(
                label: const Text('All'),
                selected: _selectedType == null,
                disable: widget.disable,
                onSelected: () => _setSelectedType(null),
              ),
              for (int i = 0; i < 4; ++i) ...[
                _TypeFilterChip(
                  label: Text(
                    '${InformationType.values[i].name[0].toUpperCase()}${InformationType.values[i].name.substring(1)}s',
                  ),
                  selected: _selectedType == InformationType.values[i],
                  disable: widget.disable,
                  onSelected: () => _setSelectedType(InformationType.values[i]),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class FilterOptionSheetWidget extends StatefulWidget {
  const FilterOptionSheetWidget({super.key});

  @override
  State<FilterOptionSheetWidget> createState() =>
      _FilterOptionSheetWidgetState();
}

class _FilterOptionSheetWidgetState extends State<FilterOptionSheetWidget> {
  int _selectedDropdown = 1;
  int _selectedTypes = 0;

  void _selectType(InformationType? type) {
    if (type == null) {
      if (_selectedTypes != 0) {
        setState(() => _selectedTypes = 0);
      }
      return;
    }

    if ((_selectedTypes & (1 << type.index)) == 0) {
      setState(() => _selectedTypes |= (1 << type.index));
    }
  }

  void _unselectType(InformationType type) {
    if ((_selectedTypes & (1 << type.index)) > 0) {
      setState(() => _selectedTypes &= ~(1 << type.index));
    }
  }

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w500,
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Filtering options',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton.icon(
              onPressed: () {},
              label: const Text('Reset filters'),
              icon: const Icon(Icons.restore),
              iconAlignment: IconAlignment.end,
            ),
          ],
        ),
        const SizedBox(height: 8),
        const Divider(
          radius: BorderRadius.all(Radius.circular(24)),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Sort by',
              style: textStyle,
            ),
            DropdownButton<int>(
              items: const [
                DropdownMenuItem(
                  value: 1,
                  child: Text('Newest first'),
                ),
                DropdownMenuItem(
                  value: 2,
                  child: Text('Oldest first'),
                ),
              ],
              value: _selectedDropdown,
              elevation: 0,
              focusColor: Colors.transparent,
              onChanged: (option) {
                if (option != null && option != _selectedDropdown) {
                  setState(() => _selectedDropdown = option);
                }
              },
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          'Information types',
          style: textStyle,
        ),
        const SizedBox(height: 6),
        Wrap(
          spacing: 4,
          children: [
            _TypeFilterChip(
              label: const Text('All'),
              selected: _selectedTypes == 0,
              onSelected: () {
                if (_selectedTypes != 0) {
                  setState(() => _selectedTypes = 0);
                }
              },
            ),
            for (int i = 0; i < 4; ++i) ...[
              _TypeFilterChip(
                label: Text(
                  '${InformationType.values[i].name[0].toUpperCase()}${InformationType.values[i].name.substring(1)}s',
                ),
                selected: (_selectedTypes & (1 << i)) > 0,
                onSelected: () => _selectType(InformationType.values[i]),
                onUnselected: () => _unselectType(InformationType.values[i]),
              ),
            ],
          ],
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            onPressed: () {},
            child: const Text('Apply filter'),
          ),
        ),
      ],
    );
  }
}

class _TypeFilterChip extends StatelessWidget {
  final Widget label;
  final bool selected;
  final bool disable;
  final VoidCallback onSelected;
  final VoidCallback? onUnselected;

  const _TypeFilterChip({
    required this.label,
    required this.selected,
    required this.onSelected,
    this.onUnselected,
    this.disable = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      color: disable
          ? theme.disabledColor
          : selected
          ? theme.brightness == Brightness.dark
                ? Colors.blueGrey
                : Colors.blueGrey.shade100
          : null,
      shape: selected || disable
          ? const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            )
          : null,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: disable
            ? null
            : selected
            ? onUnselected
            : onSelected,
        child: Padding(
          padding: const EdgeInsetsGeometry.symmetric(
            horizontal: 12,
            vertical: 6,
          ),
          child: label,
        ),
      ),
    );
  }
}
