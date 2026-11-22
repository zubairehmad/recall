import 'package:flutter/material.dart';

import '../../../core/models/information.dart';
import '../../../core/widgets/custom_search_bar.dart';

class SearchAndFilterSection extends StatefulWidget {
  const SearchAndFilterSection({super.key});

  @override
  State<SearchAndFilterSection> createState() => _SearchAndFilterSectionState();
}

class _SearchAndFilterSectionState extends State<SearchAndFilterSection> {
  InformationType? _selectedType;

  void setSelectedType(InformationType? type) {
    if (_selectedType != type) {
      setState(() => _selectedType = type);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SliverMainAxisGroup(
      slivers: [
        SliverToBoxAdapter(
          child: CustomSearchBar(
            hintText: 'Search your collection...',
            trailing: [
              IconButton(
                onPressed: () {},
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
              TypeFilterChip(
                label: const Text('All'),
                selected: _selectedType == null,
                onSelected: () => setSelectedType(null),
              ),
              TypeFilterChip(
                label: const Text('Claims'),
                selected: _selectedType == InformationType.claim,
                onSelected: () => setSelectedType(InformationType.claim),
              ),
              TypeFilterChip(
                label: const Text('Facts'),
                selected: _selectedType == InformationType.fact,
                onSelected: () => setSelectedType(InformationType.fact),
              ),
              TypeFilterChip(
                label: const Text('Tips'),
                selected: _selectedType == InformationType.tip,
                onSelected: () => setSelectedType(InformationType.tip),
              ),
              TypeFilterChip(
                label: const Text('Notes'),
                selected: _selectedType == InformationType.note,
                onSelected: () => setSelectedType(InformationType.note),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class TypeFilterChip extends StatelessWidget {
  final Widget label;
  final bool selected;
  final VoidCallback onSelected;

  const TypeFilterChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: selected
          ? Theme.of(context).brightness == Brightness.dark
                ? Colors.blueGrey
                : Colors.blueGrey.shade100
          : null,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onSelected,
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
