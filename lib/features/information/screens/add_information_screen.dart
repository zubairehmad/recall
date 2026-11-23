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

  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentControler = TextEditingController();

  @override
  void initState() {
    super.initState();

    _selectedType = widget.initialType ?? InformationType.values[0];
  }

  void _onSubmit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
  }

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
    );

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
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LayoutBuilder(
                builder: (ctx, constraints) {
                  final width =
                      (constraints.maxWidth - 18) /
                      InformationType.values.length;

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
              const SizedBox(height: 16),
              const Text(
                'Title',
                style: textStyle,
              ),
              const SizedBox(height: 8),
              TextFormField(
                maxLength: 80,
                controller: _titleController,
                validator: (v) {
                  if (v == null || v.isEmpty) {
                    return 'This field cannot be empty!';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  hintText: 'Enter a short title...',
                  counterText: '',
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Content',
                style: textStyle,
              ),
              const SizedBox(height: 8),
              TextFormField(
                minLines: 5,
                maxLines: 8,
                maxLength: 2000,
                controller: _contentControler,
                validator: (v) {
                  if (v == null || v.isEmpty) {
                    return 'This field cannot be empty!';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  hintText: 'Add your information...',
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 40,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: ElevatedButton(
                    onPressed: _onSubmit,
                    style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                    child: const Text('Save information'),
                  ),
                ),
              ),
            ],
          ),
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
      margin: EdgeInsets.zero,
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      color: isSelected ? colorScheme.primaryContainer : null,
      shape: isSelected
          ? const RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.all(Radius.circular(12)),
            )
          : null,
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsetsGeometry.all(12),
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
