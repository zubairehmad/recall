import 'package:flutter/material.dart';

import '../../../core/models/information.dart';

class AddInformationScreen extends StatefulWidget {
  static const routeName = '/add-info-screen';

  final InformationType? initialType;

  const AddInformationScreen({
    super.key,
    this.initialType,
  });

  @override
  State<AddInformationScreen> createState() => _AddInformationScreenState();
}

class _AddInformationScreenState extends State<AddInformationScreen> {
  late InformationType _selectedType;

  @override
  void initState() {
    super.initState();

    _selectedType = widget.initialType ?? InformationType.values[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Add Information',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            LayoutBuilder(
              builder: (ctx, constraints) {
                final width =
                    constraints.maxWidth / InformationType.values.length;

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(InformationType.values.length, (i) {
                    final type = InformationType.values[i];
                    return SizedBox(
                      width: width,
                      child: _InfoTypeSelector(
                        icon: type.icon,
                        label: type.displayName,
                        isSelected: _selectedType == type,
                        onPressed: () {
                          if (_selectedType != type) {
                            setState(() => _selectedType = type);
                          }
                        },
                      ),
                    );
                  }),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoTypeSelector extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  final bool isSelected;

  const _InfoTypeSelector({
    required this.icon,
    required this.label,
    required this.onPressed,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      color: isSelected ? colorScheme.primaryContainer : null,
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsetsGeometry.all(16),
          child: Column(
            children: [
              Icon(
                icon,
                color: isSelected ? colorScheme.onPrimaryContainer : null,
              ),
              const SizedBox(height: 6),
              Text(
                label,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: isSelected
                    ? TextStyle(
                        color: colorScheme.onPrimaryContainer,
                        fontWeight: FontWeight.bold,
                      )
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
