import 'package:flutter/material.dart';

import '../../../core/models/information.dart';
import '../../../core/widgets/custom_sliver_app_bar.dart';
import '../../../core/utils/date_formatter.dart';
import '../widgets/confirmation_dialog.dart';
import 'information_form_screen.dart';

class InformationDetailScreen extends StatelessWidget {
  static const routeName = '/info-details';

  final Information information;

  const InformationDetailScreen({
    super.key,
    required this.information,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const padding = 16.0;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CustomSliverAppBar(
            title: 'Information Details',
            actions: [
              IconButton(
                onPressed: () => Navigator.of(context).pushNamed(
                  InformationFormScreen.routeName,
                  arguments: {
                    'information': information,
                  },
                ),
                icon: const Icon(Icons.edit_outlined),
              ),
              IconButton(
                onPressed: () async {
                  final shouldDelete = await showConfirmationDialog(
                    context: context,
                    bodyText:
                        'Are you sure you want to perform this operation?\nThis operation cannot be undone.',
                  );

                  if (shouldDelete) {
                    // perform delete operation
                  }
                },
                icon: const Icon(
                  Icons.delete_outline,
                  color: Colors.red,
                ),
              ),
              const SizedBox(width: 8),
            ],
          ),
          SliverPadding(
            padding: const EdgeInsets.all(padding),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Row(
                  children: [
                    Chip(
                      avatar: Icon(information.type.icon, size: 18),
                      label: Text(information.type.displayName),
                    ),
                    if (information.claimStatus != null) ...[
                      const SizedBox(width: 8),
                      _ClaimStatusCard(
                        status: information.claimStatus!,
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  information.title,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  information.content,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 32),
                const Divider(),
                const SizedBox(height: 12),
                _MetadataRow(
                  label: 'Created',
                  value: DateFormatter.formatDate(information.createdAt),
                ),
                const SizedBox(height: 12),
                _MetadataRow(
                  label: 'Last edited',
                  value: information.createdAt == information.updatedAt
                      ? "Never"
                      : DateFormatter.formatDate(information.createdAt),
                ),
              ]),
            ),
          ),
        ],
      ),
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

    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.all(Radius.circular(12)),
      ),
      color: backgroundColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        child: Row(
          children: [
            Icon(
              status.icon,
              size: 18,
              color: foregroundColor,
            ),
            const SizedBox(width: 4),
            Text(
              status.displayName,
              style: TextStyle(
                color: foregroundColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MetadataRow extends StatelessWidget {
  final String label;
  final String value;

  const _MetadataRow({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        Text(value),
      ],
    );
  }
}
