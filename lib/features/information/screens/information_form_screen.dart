import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../models/information.dart';
import '../providers/information_provider.dart';
import '../widgets/confirmation_dialog.dart';
import '../../../core/widgets/custom_sliver_app_bar.dart';

class InformationFormScreen extends StatefulWidget {
  static const routeName = '/add-info-screen';

  final InformationType? initialType;
  final Information? information;

  const InformationFormScreen({
    super.key,
    this.initialType,
    this.information,
  });

  @override
  State<InformationFormScreen> createState() => _InformationFormScreenState();
}

class _InformationFormScreenState extends State<InformationFormScreen> {
  late InformationType _selectedType;
  late bool _isEditing;

  final _formKey = GlobalKey<FormState>();
  final _selectedStatus = ValueNotifier(ClaimStatus.unreviewed);
  late final ClaimStatus _initialValue;
  final _titleController = TextEditingController();
  final _contentControler = TextEditingController();

  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();

    _initialValue = widget.information?.claimStatus ?? ClaimStatus.unreviewed;

    if (widget.information != null) {
      final info = widget.information!;

      _selectedType = info.type;
      if (info.isClaim) {
        _selectedStatus.value = info.claimStatus!;
      }
      _titleController.text = info.title;
      _contentControler.text = info.content;
      _isEditing = true;
    } else {
      _selectedType = widget.initialType ?? InformationType.values[0];
      _isEditing = false;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentControler.dispose();
    _selectedStatus.dispose();
    super.dispose();
  }

  bool get _canSubmit {
    if (_isSubmitting) return false;

    final title = _titleController.text.trim();
    final content = _contentControler.text.trim();

    if (title.isEmpty || content.isEmpty) return false;

    if (!_isEditing) return true;

    final info = widget.information!;

    return title != info.title ||
        content != info.content ||
        _selectedType != info.type ||
        (_selectedType == InformationType.claim &&
            _selectedStatus.value != info.claimStatus);
  }

  Future<void> _onSubmit() async {
    if (_isSubmitting || !(_formKey.currentState?.validate() ?? false)) return;

    final title = _titleController.text.trim();
    final content = _contentControler.text.trim();
    final now = DateTime.now();
    final infoProvider = context.read<InformationProvider>();

    setState(() => _isSubmitting = true);

    try {
      if (_isEditing) {
        if (_selectedType != widget.information!.type) {
          final shouldProceed = await showConfirmationDialog(
            context: context,
            bodyText:
                'You have updated information type from ${widget.information!.type.displayName} '
                'to ${_selectedType.displayName}. Are you still sure you want to save these changes?',
          );

          if (!shouldProceed) return;
        }

        final upd = widget.information!.copyWith(
          title: title,
          content: content,
          type: _selectedType,
          claimStatus: _selectedType == InformationType.claim
              ? _selectedStatus.value
              : null,
          updatedAt: now,
        );

        if (await infoProvider.updateInformation(upd) && mounted) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                content: Text('Saved changes successfully!'),
              ),
            );
        }
      } else {
        final newInfo = Information(
          id: const Uuid().v4(),
          title: title,
          content: content,
          type: _selectedType,
          claimStatus: _selectedType == InformationType.claim
              ? _selectedStatus.value
              : null,
          createdAt: now,
          updatedAt: now,
        );

        if (await infoProvider.addInformation(newInfo) && mounted) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(
                  '${_selectedType.displayName} added successfully!',
                ),
              ),
            );
        }
      }

      if (mounted) {
        Navigator.of(context).pop();
      }
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  String? _emptyValidator(String? v) {
    if (v == null || v.isEmpty) {
      return 'This field cannot be empty!';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
    );

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CustomSliverAppBar(
            title: _isEditing ? 'Edit Information' : 'Add Information',
            centerTitle: true,
          ),
          SliverToBoxAdapter(
            child: Form(
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
                          children: List.generate(
                            InformationType.values.length,
                            (
                              i,
                            ) {
                              final type = InformationType.values[i];
                              return SizedBox(
                                width: width,
                                child: _InfoTypeSelector(
                                  icon: type.icon,
                                  label: type.displayName,
                                  disable: _isSubmitting,
                                  isSelected: _selectedType == type,
                                  onPressed: () {
                                    if (_selectedType != type) {
                                      setState(() => _selectedType = type);
                                    }
                                  },
                                ),
                              );
                            },
                          ),
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
                      minLines: 1,
                      maxLines: 2,
                      maxLength: 80,
                      controller: _titleController,
                      enabled: !_isSubmitting,
                      validator: _emptyValidator,
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
                      enabled: !_isSubmitting,
                      validator: _emptyValidator,
                      decoration: const InputDecoration(
                        hintText: 'Add your information...',
                      ),
                    ),
                    if (_selectedType == InformationType.claim) ...[
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Claim Status',
                            style: textStyle,
                          ),
                          const SizedBox(width: 18),
                          Flexible(
                            child: ValueListenableBuilder<ClaimStatus>(
                              valueListenable: _selectedStatus,
                              builder: (context, value, child) {
                                final brightness = Theme.of(context).brightness;

                                return DropdownMenu<ClaimStatus>(
                                  initialSelection: _initialValue,
                                  selectOnly: true,
                                  leadingIcon: Icon(
                                    value.icon,
                                    color: value.getForegroundColor(brightness),
                                  ),
                                  inputDecorationTheme: InputDecorationTheme(
                                    filled: true,
                                    fillColor: value.getBackgroundColor(
                                      brightness,
                                    ),
                                  ),
                                  textStyle: TextStyle(
                                    color: value.getForegroundColor(brightness),
                                  ),
                                  menuStyle: const MenuStyle(
                                    padding: WidgetStatePropertyAll(
                                      EdgeInsets.zero,
                                    ),
                                  ),
                                  dropdownMenuEntries: ClaimStatus.values
                                      .map(
                                        (status) => DropdownMenuEntry(
                                          value: status,
                                          leadingIcon: Icon(status.icon),
                                          label: status.displayName,
                                          style: ButtonStyle(
                                            backgroundColor:
                                                WidgetStatePropertyAll(
                                                  status.getBackgroundColor(
                                                    brightness,
                                                  ),
                                                ),
                                            foregroundColor:
                                                WidgetStatePropertyAll(
                                                  status.getForegroundColor(
                                                    brightness,
                                                  ),
                                                ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                  onSelected: (newStatus) {
                                    if (newStatus != null) {
                                      _selectedStatus.value = newStatus;
                                    }
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                    ],
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: AnimatedBuilder(
                          animation: Listenable.merge([
                            _titleController,
                            _contentControler,
                            _selectedStatus,
                          ]),
                          builder: (context, child) {
                            return ElevatedButton(
                              onPressed: _canSubmit ? _onSubmit : null,
                              style: ElevatedButton.styleFrom(
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(12),
                                  ),
                                ),
                              ),
                              child: _isSubmitting
                                  ? const SizedBox.square(
                                      dimension: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2.5,
                                      ),
                                    )
                                  : _isEditing
                                  ? const Text('Save changes')
                                  : const Text('Save information'),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoTypeSelector extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  final bool disable;
  final bool isSelected;

  const _InfoTypeSelector({
    required this.icon,
    required this.label,
    required this.onPressed,
    required this.isSelected,
    this.disable = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      color: disable && isSelected
          ? theme.disabledColor
          : disable
          ? colorScheme.surface.withAlpha(160)
          : isSelected
          ? colorScheme.primaryContainer
          : null,
      shape: isSelected
          ? const RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.all(Radius.circular(12)),
            )
          : null,
      child: InkWell(
        onTap: disable ? null : onPressed,
        child: Padding(
          padding: const EdgeInsetsGeometry.all(12),
          child: Column(
            children: [
              Icon(
                icon,
                color: isSelected
                    ? colorScheme.onPrimaryContainer
                    : disable
                    ? colorScheme.onSurface.withAlpha(160)
                    : null,
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
                    : disable
                    ? TextStyle(
                        color: colorScheme.onSurface.withAlpha(160),
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
