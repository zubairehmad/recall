import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'information_form_screen.dart';
import '../models/information.dart';
import '../providers/information_provider.dart';
import '../widgets/confirmation_dialog.dart';
import '../../../core/utils/date_formatter.dart';
import '../../../core/widgets/custom_sliver_app_bar.dart';

class InformationDetailScreen extends StatefulWidget {
  static const routeName = '/info-details';

  final String infoId;

  const InformationDetailScreen({
    super.key,
    required this.infoId,
  });

  @override
  State<InformationDetailScreen> createState() =>
      _InformationDetailScreenState();
}

class _InformationDetailScreenState extends State<InformationDetailScreen> {
  final _isLoading = ValueNotifier(false);

  @override
  void dispose() {
    _isLoading.dispose();
    super.dispose();
  }

  Future<void> _handleDelete(String id) async {
    if (_isLoading.value) return;

    _isLoading.value = true;

    try {
      final infoProvider = context.read<InformationProvider>();
      final shouldDelete = await showConfirmationDialog(
        context: context,
        bodyText:
            'Are you sure you want to perform this operation?\nThis operation cannot be undone.',
      );

      if (shouldDelete && await infoProvider.deleteInformation(id) && mounted) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            const SnackBar(
              content: Text('Deleted successfully!'),
            ),
          );
        Navigator.of(context).pop();
      }
    } finally {
      _isLoading.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final information = context.select<InformationProvider, Information?>(
      (p) => p.getInfo(widget.infoId),
    );

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          ValueListenableBuilder(
            valueListenable: _isLoading,
            builder: (context, isLoading, _) {
              return CustomSliverAppBar(
                title: 'Information Details',
                actions: [
                  IconButton(
                    onPressed: information == null || isLoading
                        ? null
                        : () => Navigator.of(context).pushNamed(
                            InformationFormScreen.routeName,
                            arguments: {
                              'information': information,
                            },
                          ),
                    icon: const Icon(Icons.edit_outlined),
                  ),
                  IconButton(
                    onPressed: information == null || isLoading
                        ? null
                        : () => _handleDelete(information.id),
                    icon: const Icon(
                      Icons.delete_outline,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
              );
            },
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverToBoxAdapter(
              child: _InformationCard(
                information: information,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InformationCard extends StatelessWidget {
  final Information? information;

  const _InformationCard({
    required this.information,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    if (information == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLow,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        border: Border.all(
          color: colorScheme.outlineVariant,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _InformationTypeBadge(
                type: information!.type,
              ),
              if (information!.isClaim)
                _ClaimStatusCard(
                  status: information!.claimStatus!,
                ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            information!.title,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            information!.content,
            style: theme.textTheme.bodyLarge?.copyWith(
              height: 1.6,
            ),
          ),
          const SizedBox(height: 24),
          Divider(
            color: colorScheme.outlineVariant,
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 20,
            runSpacing: 8,
            children: [
              _MetadataItem(
                icon: Icons.calendar_today_outlined,
                value: DateFormatter.formatDate(
                  information!.createdAt,
                ),
              ),
              _MetadataItem(
                icon: Icons.edit_calendar_outlined,
                value: information!.createdAt == information!.updatedAt
                    ? 'Never edited'
                    : DateFormatter.formatDate(
                        information!.updatedAt,
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _InformationTypeBadge extends StatelessWidget {
  final InformationType type;

  const _InformationTypeBadge({
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: Icon(
        type.icon,
        size: 18,
      ),
      label: Text(type.displayName),
    );
  }
}

class _ClaimStatusCard extends StatelessWidget {
  final ClaimStatus status;

  const _ClaimStatusCard({
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    final foregroundColor = status.getForegroundColor(brightness);
    final backgroundColor = status.getBackgroundColor(brightness);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            status.icon,
            size: 18,
            color: foregroundColor,
          ),
          const SizedBox(width: 6),
          Text(
            status.displayName,
            style: TextStyle(
              color: foregroundColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _MetadataItem extends StatelessWidget {
  final IconData icon;
  final String value;

  const _MetadataItem({
    required this.icon,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.onSurfaceVariant;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 14,
          color: color,
        ),
        const SizedBox(width: 6),
        Text(
          value,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: color,
          ),
        ),
      ],
    );
  }
}
